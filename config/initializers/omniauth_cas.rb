Rails.application.config.middleware.use OmniAuth::Builder do
  provider :cas, url: "https://cas-auth.rpi.edu/cas"
end