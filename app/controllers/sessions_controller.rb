class SessionsController < ApplicationController
	def create
    auth = request.env["omniauth.auth"]
    user = User.where(:email => auth["info"]["email"]).first_or_initialize(
      :email => auth["info"]["email"]
    )

    url = session[:return_to] || root_path
    session[:return_to] = nil
    url = root_path if url.eql?('/logout')

    unless user.id
      # the user is new, direct them to the form to edit profile and send an email
      UserMailer.welcome_email(user).deliver
      url = nil
    end

    if user.save
      session[:user_id] = user.id
      notice = "Signed in!"
      if url
        logger.debug "URL to redirect to: #{url}"
        redirect_to url, :notice => notice
      else
        logger.debug "URL to redirect to: /users/#{user.id}/edit"
        redirect_to "/users/#{user.id}/edit"
      end
    else
      raise "Failed to login"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
