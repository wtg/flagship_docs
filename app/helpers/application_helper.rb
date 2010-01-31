# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

 def background_img(category = nil)
   if !category.background.nil?
     result = '<style type="text/css">'
     result += "body { background:#FFFFFF url(#{image_path(category.background.image.url)}) top left repeat; }"
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
 
 #Boilerplate methods, should be overridden by your authentication system.
 def current_user
   nil
 end
 def logged_in?
   true
 end
 def admin_logged_in?
   true
 end

end
