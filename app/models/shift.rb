class Shift < ActiveRecord::Base
  belongs_to :coop

  def isLeader
  end

  def isLeader=(checkbox)
  end
end
