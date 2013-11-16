class Shift < ActiveRecord::Base
  belongs_to :coop
  has_and_belongs_to_many :users

  def isLeader
  end

  def isLeader=(checkbox)
  end
end
