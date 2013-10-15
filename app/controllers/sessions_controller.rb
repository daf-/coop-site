class SessionsController < ApplicationController
	def create
    auth = request.env["omniauth.auth"]
    user = User.where(:email => auth["info"]["email"]).first_or_initialize(
      :email => auth["info"]["email"]
    )
    url = session[:return_to] || root_path
    session[:return_to] = nil
    url = root_path if url.eql?('/logout')

    if user.save
      session[:user_id] = user.id
      notice = "Signed in!"
      logger.debug "URL to redirect to: #{url}"
      redirect_to url, :notice => notice
    else
      raise "Failed to login"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
