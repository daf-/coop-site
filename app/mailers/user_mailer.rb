class UserMailer < ActionMailer::Base
  default from: "no_reply@coop_site.com"

  def welcome_email(user)
    @user = user
    @url = 'http://localhost:3000'
    mail(to: @user.email, subject: "Welcome to the coop hub site thing")
  end

  def coop_join_info_email(user)
    @user = user
    @url = 'http://localhost:3000/' + user.coop.join_hash
    mail(to: @user.email, subject: "Get your coop involved!")
  end
end