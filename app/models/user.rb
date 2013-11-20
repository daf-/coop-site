class User < ActiveRecord::Base
  belongs_to :coop
  has_many :swap_requests
  has_and_belongs_to_many :shifts
  validates_uniqueness_of :email

  after_create :send_account_create_email
  before_save :clean_phone

  def phone_pretty
    number_to_phone(self.phone, area_code: true)
  end

  def send_account_create_email
    UserMailer.welcome_email(self).deliver
  end

  private
    def clean_phone
      if self.phone
        self.phone.gsub!(/[^0-9]/, '')
      end
    end
end
