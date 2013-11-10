class SessionsController < ApplicationController
	def create
    auth = request.env["omniauth.auth"]
    if current_user
      # user followed coop sign up link
      user = current_user
      user.email = auth["info"]["email"]
      new_user = true
    else
      user = User.where(:email => auth["info"]["email"]).first_or_initialize(
        :email => auth["info"]["email"]
      )
    end

    url = session[:return_to] || root_path
    session[:return_to] = nil
    url = root_path if url.eql?('/logout')

    if user.new_record?
      # the user is new, direct them to the form to edit profile and send an email
      new_user = true
      url = nil
    end

    if user.save
      session[:user_id] = user.id

      if newUser
        UserMailer.welcome_email(user).deliver
      end

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
