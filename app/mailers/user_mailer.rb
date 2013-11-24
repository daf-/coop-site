class UserMailer < ActionMailer::Base
  default from: "root@radradishes.cs.oberlin.edu"

  def welcome_email(user)
    @user = user
    @url = 'http://radradishes.cs.oberlin.edu'
    mail(to: @user.email, subject: "Welcome to the coop hub site thing")
  end

  def coop_join_info_email(user, coop)
    @user = user
    @coop = coop
    @url = "http://radradishes.cs.oberlin.edu/coops/#{coop.id}/member_join_link/#{coop.member_join_hash}"
    mail(to: @user.email, subject: "Join #{@coop.name} as a member!")
  end

  def coop_admin_email(user, coop)
    @user = user
    @coop = coop
    @url = "http://radradishes.cs.oberlin.edu/coops/#{coop.id}/admin_join_link/#{coop.admin_join_hash}"
    mail(to: @user.email, subject: "Join #{@coop.name} as an admin!")
  end
end
