require 'find'

current_directory = Dir.pwd
md_files = Hash.new{|hash, key| hash[key] = {} }

Find.find(current_directory) do |path|
  if FileTest.directory?(path)
    # ignore any directories starting with .
    if File.basename(path)[0] == "."
      Find.prune
    else
      next
    end
  else
    # ignore any node_module directories
    if path[( path.size - 2 )..( path.size - 1 )] == "md" && path.split("/node_modules/").size == 1
        week_number_start = path.split("week_")[1]
        week_number = week_number_start.split("/")[0]
        day_string = week_number_start.split("/")[1]
        if md_files[week_number][day_string] == nil
          md_files[week_number][day_string] = []
        end
        md_files[week_number][day_string] << "<a href=\"#{path}\">#{File.basename(path)}</a>"
    else
      next
    end
  end
end

output = open("classnotes_md_index.html", 'w')

for week in 1..16
  key = week.to_s
  hash_for_week = md_files[key]
  output.write("<h1>Week #{key}</h1>")

  hash_for_week.each do |day_key, md_array|
    output.write("<h2>#{day_key}</h2>")
    md_array.each do |html|
      output.write("<h3>#{html}</h3>")
    end
  end

end

output.close
