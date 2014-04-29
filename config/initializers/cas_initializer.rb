require 'casclient'
require 'casclient/frameworks/rails/filter'
 
 # Configuration to point to Central Authentication System server.
 # Make sure the rubycas-client plugin is intalled.
 # See http://rubycas-client.rubyforge.org/
  
	CASClient::Frameworks::Rails::Filter.configure(
	    :cas_base_url => "https://cas-auth.rpi.edu/cas/"
			)
			 
