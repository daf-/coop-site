class UserMailer < ActionMailer::Base
  default from: "no_reply@coop_site.com"

  def welcome_email(user)
    @user = user
    @url = 'http://localhost:3000'
    mail(to: @user.email, subject: "Welcome to the coop hub site thing")
  end

  def coop_join_info_email(user, coop)
    @user = user
    @url = "http://localhost:3000/coops/#{coop.id}/join_link/#{coop.member_join_hash}"
    mail(to: @user.email, subject: "Get your coop involved!")
  end

  def coop_admin_emails(users, coop)
  end
end
