class User < ActiveRecord::Base
  belongs_to :coop
  has_many :swap_requests
	validates_uniqueness_of :email

  after_create :send_account_create_email

  def send_account_create_email
    UserMailer.welcome_email(self).deliver
  end
end
