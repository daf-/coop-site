class SessionsController < ApplicationController
	def create
    auth = request.env["omniauth.auth"]

    user = User.where(:email => auth["info"]["email"]).first_or_initialize(
      :email => auth["info"]["email"],
    )
    new_user_bool = user.new_record?

    if user.new_record?
      unless current_coop
        redirect_to root_path, :notice => "Permission denied"
        return # prevents falling through the rest of the file
      end
      if session[:return_to] == 'new admin'
        user.admin = true
      end
      user.coop = current_coop
    end

    if user.save
      session[:user_id] = user.id
      session[:coop_id] = user.coop_id

      if new_user_bool
        notice = "New account created!"
        redirect_to edit_user_path(user.id), :notice => notice
      else
        notice = "Signed in!"
        redirect_to coop_path(user.coop_id), :notice => notice
      end
    else
      raise "Failed to login"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:coop_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
