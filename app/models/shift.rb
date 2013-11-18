class Shift < ActiveRecord::Base
  belongs_to :coop
  has_and_belongs_to_many :users
  has_and_belongs_to_many :meals

  def isLeader
  end

  def isLeader=(checkbox)
  end

  def self.makeForMeals(meals, params, coop, shifts)
    if (shifts)
    end
  end
end
