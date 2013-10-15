Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "950188685519.apps.googleusercontent.com", "Ky_jXimiE8fsRBSGxPjLBc3e",
  	{
  		:name => "google_login",
  		:scope => "userinfo.email",
  		:approval_prompt => ''
  	}
end