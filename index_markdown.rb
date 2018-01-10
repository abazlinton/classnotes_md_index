require 'find'

current_directory = Dir.pwd
output = open("classnotes_md_index.html", 'w')

Find.find(current_directory) do |path|
    parts = path.split("/")
    if parts.last[-2..-1] == "md"
      link_text = path.split(current_directory + "/").last
      output.write("<p><a href=\"#{path}\">#{link_text}</a></p>")
    end
end

output.close




