class Coop < ActiveRecord::Base

  has_many :meals
  has_many :users
  has_many :shifts
  has_many :swap_requests

  before_create :update_admin_join_hash
  before_create :update_member_join_hash

  def update_admin_join_hash
    self.admin_join_hash = SecureRandom.hex
  end

  def update_member_join_hash
    self.member_join_hash = SecureRandom.hex
  end

  def kp_breakfast?
    return self.kp && self.kp.count('b')
  end

  def kp_lunch?
    return self.kp && self.kp.count('l')
  end

  def kp_dinner?
    return self.kp && self.kp.count('d')
  end

  def cook_1_breakfast?
    return self.cook_1 && self.cook_1.count('b')
  end

  def cook_1_lunch?
    return self.cook_1 && self.cook_1.count('l')
  end

  def cook_1_dinner?
    return self.cook_1 && self.cook_1.count('d')
  end

  def cook_2_breakfast?
    return self.cook_2 && self.cook_2.count('b')
  end

  def cook_2_lunch?
    return self.cook_2 && self.cook_2.count('l')
  end

  def cook_2_dinner?
    return self.cook_2 && self.cook_2.count('d')
  end

  def pre_crew_breakfast?
    return self.pre_crew && self.pre_crew.count('b')
  end

  def pre_crew_lunch?
    return self.pre_crew && self.pre_crew.count('l')
  end

  def pre_crew_dinner?
    return self.pre_crew && self.pre_crew.count('d')
  end

  def crew_breakfast?
    return self.crew && self.crew.count('b')
  end

  def crew_lunch?
    return self.crew && self.crew.count('l')
  end

  def crew_dinner?
    return self.crew && self.crew.count('d')
  end

# breakfast!!
  def breakfast?
    return self.monday_breakfast? || self.tuesday_breakfast? || self.wednesday_breakfast? || self.thursday_breakfast? || self.friday_breakfast? || self.saturday_breakfast? || self.sunday_breakfast?
  end

  def monday_breakfast?
  	return self.monday && self.monday.count('b')
  end
  def monday_breakfast=(on)
  	if on
  		self.monday << 'b'
  	end
  end

  def tuesday_breakfast?
    return self.tuesday && self.tuesday.count('b')
  end
  def tuesday_breakfast=(on)
    if on
      self.tuesday << 'b'
    end
  end

  def wednesday_breakfast?
    return self.wednesday && self.wednesday.count('b')
  end
  def wednesday_breakfast=(on)
    if on
      self.wednesday << 'b'
    end
  end

  def thursday_breakfast?
    return self.thursday && self.thursday.count('b')
  end
  def thursday_breakfast=(on)
    if on
      self.thursday << 'b'
    end
  end

  def friday_breakfast?
    return self.friday && self.friday.count('b')
  end
  def friday_breakfast=(on)
    if on
      self.friday << 'b'
    end
  end

  def saturday_breakfast?
    return self.saturday && self.saturday.count('b')
  end
  def saturday_breakfast=(on)
    if on
      self.saturday << 'b'
    end
  end

  def sunday_breakfast?
    return self.sunday && self.sunday.count('b')
  end
  def sunday_breakfast=(on)
    if on
      self.sunday << 'b'
    end
  end

  # lunch!!
  def lunch?
    return self.monday_lunch? || self.tuesday_lunch? || self.wednesday_lunch? || self.thursday_lunch? || self.friday_lunch? || self.saturday_lunch? || self.sunday_lunch?
  end

  def monday_lunch?
    return self.monday && self.monday.count('l')
  end
  def monday_lunch=(on)
    if on
      self.monday << 'l'
    end
  end

  def tuesday_lunch?
    return self.tuesday && self.tuesday.count('l')
  end
  def tuesday_lunch=(on)
    if on
      self.tuesday << 'l'
    end
  end

  def wednesday_lunch?
    return self.wednesday && self.wednesday.count('l')
  end
  def wednesday_lunch=(on)
    if on
      self.wednesday << 'l'
    end
  end

  def thursday_lunch?
    return self.thursday && self.thursday.count('l')
  end
  def thursday_lunch=(on)
    if on
      self.thursday << 'l'
    end
  end

  def friday_lunch?
    return self.friday && self.friday.count('l')
  end
  def friday_lunch=(on)
    if on
      self.friday << 'l'
    end
  end

  def saturday_lunch?
    return self.tuesday && self.saturday.count('l')
  end
  def saturday_lunch=(on)
    if on
      self.saturday << 'l'
    end
  end

  def sunday_lunch?
    return self.saturday && self.sunday.count('l')
  end
  def sunday_lunch=(on)
    if on
      self.sunday << 'l'
    end
  end

  # dinner!!
  def dinner?
    return self.monday_dinner? || self.tuesday_dinner? || self.wednesday_dinner? || self.thursday_dinner? || self.friday_dinner? || self.saturday_dinner? || self.sunday_dinner?
  end

  def monday_dinner?
    return self.monday && self.monday.count('d')
  end
  def monday_dinner=(on)
    if on
      self.monday << 'd'
    end
  end

  def tuesday_dinner?
    return self.tuesday && self.tuesday.count('d')
  end
  def tuesday_dinner=(on)
    if on
      self.tuesday << 'd'
    end
  end

  def wednesday_dinner?
    return self.wednesday && self.wednesday.count('d')
  end
  def wednesday_dinner=(on)
    if on
      self.wednesday << 'd'
    end
  end

  def thursday_dinner?
    return self.thursday && self.thursday.count('d')
  end
  def thursday_dinner=(on)
    if on
      self.thursday << 'd'
    end
  end

  def friday_dinner?
    return self.friday && self.friday.count('d')
  end
  def friday_dinner=(on)
    if on
      self.friday << 'd'
    end
  end

  def saturday_dinner?
    return self.saturday && self.saturday.count('d')
  end
  def saturday_dinner=(on)
    if on
      self.saturday << 'd'
    end
  end

  def sunday_dinner?
    return self.sunday && self.sunday.count('d')
  end
  def sunday_dinner=(on)
    if on
      self.sunday << 'd'
    end
  end
end
