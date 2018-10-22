Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['93b2b9bc5913f552212f'], ENV['71d16903461a2dcc1c4ae742ca72dd9ab97e9c1f']
end