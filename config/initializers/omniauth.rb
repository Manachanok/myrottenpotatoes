# config/initializers/omniauth.rb
# Replace API_KEY and API_SECRET with the values you got from Twitter
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "Yay5I7LhlRdFOSewwxalvc6ZD", "ppzjnvCO4XrJiI9RhZtsgBUDUkZLD1XzCjInHsduobhSYdULux"
  provider :facebook, "388850541820839", "3cf6767372082ec3e27123a9dbfcb16c"
end

def OmniAuth.login_path(provider)
  "/auth/#{provider}"
end

