# Mitigate CVE-2013-0156
ActionController::Base.param_parsers.delete(Mime::XML) 
