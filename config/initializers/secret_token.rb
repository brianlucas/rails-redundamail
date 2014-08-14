secret = Rails.env.production? ? ENV['SECRET_TOKEN'] : "top_secret_token"
YourApp::Application.config.secret_key_base = secret