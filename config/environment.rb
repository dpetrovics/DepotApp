#THIS FILE CONTAINS CONFIGURATION FOR DEVELOPMENT, PRODUCTION AND TEST ENVIRONMENTS

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
DepotApp::Application.initialize!

#set up the mailer
DepotApp::Application.configure do 
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address    =>  "smtp.gmail.com",
    :port       =>  587,
    :domain     =>  "localhost.localdomain",
    :authentication =>  "plain",
    :user_name      =>  "usernamehere",
    :password       =>  "passwordhere",
    :enable_starttls_auto => true
  }
end