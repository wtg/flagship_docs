# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

 def background_img(category = nil)
   if !category.background.nil?
     result = '<style type="text/css">'
     result += "body { background:#FFFFFF url(#{image_path(category.background.image.url)}) repeat scroll left top; }"
     result += '</style>'
     result
   end
 end

 def meta_tags(title = nil, description = nil, img = nil, *other)
   result = ""
   result += "<meta name='title' content='#{title}' />\n" unless title.blank?
   result += "<meta name='description' content='#{h(description)}' />\n" unless description.blank?
   result += "<link rel='image_src' href='#{image_path(img)}' />\n" unless img.blank?
   result += other.join("\n")
   result
 end

end
