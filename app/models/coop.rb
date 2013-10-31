class Coop < ActiveRecord::Base

  has_many :meals

  def breakfast_fields
  days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday']
    bfasts = {}
    days.each do |day|
      bfasts[day] = self[day] && self[day].count('b')
    end
    bfasts
  end

  def breakfast_fields=(bools)
    puts bools
  end

# breakfast!!
  def monday_breakfast
  	return self.monday && self.monday.count('b')
  end
  def monday_breakfast=(on)
  	if on
  		self.monday += 'b'
  	end
  end

  def tuesday_breakfast
    return self.tuesday && self.tuesday.count('b')
  end
  def tuesday_breakfast=(on)
    if on
      self.tuesday += 'b'
    end
  end

  def wednesday_breakfast
    return self.wednesday && self.wednesday.count('b')
  end
  def wednesday_breakfast=(on)
    if on
      self.wednesday += 'b'
    end
  end

  def thursday_breakfast
    return self.thursday && self.thursday.count('b')
  end
  def thursday_breakfast=(on)
    if on
      self.thursday += 'b'
    end
  end

  def friday_breakfast
    return self.friday && self.friday.count('b')
  end
  def friday_breakfast=(on)
    if on
      self.friday += 'b'
    end
  end

  def saturday_breakfast
    return self.saturday && self.saturday.count('b')
  end
  def saturday_breakfast=(on)
    if on
      self.saturday += 'b'
    end
  end

  def sunday_breakfast
    return self.sunday && self.sunday.count('b')
  end
  def sunday_breakfast=(on)
    if on
      self.sunday += 'b'
    end
  end

  # lunch!!
  def monday_lunch
    return self.monday && self.monday.count('l')
  end
  def monday_lunch=(on)
    if on
      self.monday += 'l'
    end
  end

  def tuesday_lunch
    return self.tuesday && self.tuesday.count('l')
  end
  def tuesday_lunch=(on)
    if on
      self.tuesday += 'l'
    end
  end

  def wednesday_lunch
    return self.wednesday && self.wednesday.count('l')
  end
  def wednesday_lunch=(on)
    if on
      self.wednesday += 'l'
    end
  end

  def thursday_lunch
    return self.thursday && self.thursday.count('l')
  end
  def thursday_lunch=(on)
    if on
      self.thursday += 'l'
    end
  end

  def friday_lunch
    return self.friday && self.friday.count('l')
  end
  def friday_lunch=(on)
    if on
      self.friday += 'l'
    end
  end

  def saturday_lunch
    return self.tuesday && self.saturday.count('l')
  end
  def saturday_lunch=(on)
    if on
      self.saturday += 'l'
    end
  end

  def sunday_lunch
    return self.saturday && self.sunday.count('l')
  end
  def sunday_lunch=(on)
    if on
      self.sunday += 'l'
    end
  end

  # dinner!!
  def monday_dinner
    return self.monday && self.monday.count('d')
  end
  def monday_dinner=(on)
    if on
      self.monday += 'd'
    end
  end

  def tuesday_dinner
    return self.tuesday && self.tuesday.count('d')
  end
  def tuesday_dinner=(on)
    if on
      self.tuesday += 'd'
    end
  end

  def wednesday_dinner
    return self.wednesday && self.wednesday.count('d')
  end
  def wednesday_dinner=(on)
    if on
      self.wednesday += 'd'
    end
  end

  def thursday_dinner
    return self.thursday && self.thursday.count('d')
  end
  def thursday_dinner=(on)
    if on
      self.thursday += 'd'
    end
  end

  def friday_dinner
    return self.friday && self.friday.count('d')
  end
  def friday_dinner=(on)
    if on
      self.friday += 'd'
    end
  end

  def saturday_dinner
    return self.saturday && self.saturday.count('d')
  end
  def saturday_dinner=(on)
    if on
      self.saturday += 'd'
    end
  end

  def sunday_dinner
    return self.sunday && self.sunday.count('d')
  end
  def sunday_dinner=(on)
    if on
      self.sunday += 'd'
    end
  end
end
