require 'textractor'

Textractor.clear_registry

Textractor.register_content_type("application/msword") do |path|
  `catdoc -w #{path}`
end

Textractor.register_content_type("application/vnd.ms-excel") do |path|
  `xls2cvs #{path}`
end

Textractor.register_content_type("application/vnd.ms-powerpoint") do |path|
  `catppt #{path}`
end

Textractor.register_content_type("application/vnd.openxmlformats-officedocument.wordprocessingml.document") do |path|
  `doctotext #{path}`
end

Textractor.register_content_type("application/vnd.openxmlformats-officedocument.presentationml.presentation") do |path|
  `doctotext  #{path}`
end

Textractor.register_content_type("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") do |path|
  `doctotext #{path}`
end

Textractor.register_content_type("image/jpeg") do |path|
  `jhead -c #{path}`
end

Textractor.register_content_type("image/png") do |path|
  `jhead -c #{path}`
end

Textractor.register_content_type("application/vnd.oasis.opendocument.text") do |path|
  `odt2txt #{path}`
end

Textractor.register_content_type("application/vnd.oasis.opendocument.presentation") do |path|
  `odt2txt #{path}`
end

Textractor.register_content_type("application/vnd.oasis.opendocument.spreadsheet") do |path|
  `odt2txt #{path}`
end
