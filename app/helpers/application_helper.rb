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

end
