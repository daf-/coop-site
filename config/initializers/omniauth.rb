Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "244243145257.apps.googleusercontent.com", "VRydUjDS66gKXb87HGHz-1ot",
  	{
  		:name => "google_login",
  		:scope => "userinfo.email",
  		:approval_prompt => ''
  	}
end