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


  def set_meals_shifts(meal_shift_hash)
    update_hash = {}
    ['breakfast', 'lunch', 'dinner'].each do |meal|
      # check days
      ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday'].each do |day|
        if meal_shift_hash[day + '_' + meal]
          if update_hash[day]
            update_hash[day] << meal[0]
          else
            update_hash[day] = meal[0]
          end
        end
      end
      # check shifts
      ['kp', 'cook_1', 'cook_2', 'pre_crew', 'crew'].each do |shift|
        if meal_shift_hash[shift + '_' + meal]
          if update_hash[shift]
            update_hash[shift] << meal[0]
          else
            update_hash[shift] = meal[0]
          end
        end
      end
    end
    update_hash
  end

  def set_non_meal_shifts(non_meal_shift_hash)
    update_hash = {}
    ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday'].each do |day|
      ['commando', 'mid_crew', 'other_shift'].each do |shift|
        if non_meal_shift_hash[day + '_' + shift]
          if update_hash[shift]
            update_hash[shift] << day[0..2]
          else
            update_hash[shift] = day[0..2]
          end
        end
      end
    end
    update_hash
  end

  def no_meal(type)
    char = type[0]
    ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday'].each do |day|
      if self[day]
        self[day].gsub!(char, "")
      end
    end

    self.kp.gsub!(char, "") if self.kp
    self.crew.gsub!(char, "") if self.crew
    self.pre_crew.gsub!(char, "") if self.pre_crew
    self.cook_1.gsub!(char, "") if self.cook_1
    self.cook_2.gsub!(char, "") if self.cook_2

    if type == 'breakfast'
      self.bfast_time = Time.parse("9:00AM")
      self.custom_shift_1_b = ""
      self.custom_shift_2_b = ""
      self.custom_shift_3_b = ""

    elsif type == 'lunch'
      self.lunch_time = Time.parse("12:20PM")
      self.custom_shift_1_l = ""
      self.custom_shift_2_l = ""
      self.custom_shift_3_l = ""

    elsif type == 'dinner'
      self.dinner_time = Time.parse("6:20PM")
      self.custom_shift_1_d = ""
      self.custom_shift_2_d = ""
      self.custom_shift_3_d = ""

    end
  end

  def no_shift(type)
    if self[type]
      ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat'].each do |day|
        self[type].gsub!(day, "")
      end
    end

    if type == 'other_shift'
      self.other_shift_name = ""
    end

    self[type+"_time"] = Time.parse("12:00AM")
  end

  def commando?
    return self.monday_commando || self.tuesday_commando || self.wednesday_commando || self.thursday_commando || self.friday_commando || self.saturday_commando || self.sunday_commando
  end

  def monday_commando
    return self.commando && self.commando.include?('mon')
  end

  def tuesday_commando
    return self.commando && self.commando.include?('tue')
  end

  def wednesday_commando
    return self.commando && self.commando.include?('wen')
  end

  def thursday_commando
    return self.commando && self.commando.include?('thu')
  end

  def friday_commando
    return self.commando && self.commando.include?('fri')
  end

  def saturday_commando
    return self.commando && self.commando.include?('sat')
  end

  def sunday_commando
    return self.commando && self.commando.include?('sun')
  end

  def mid_crew?
    return self.monday_mid_crew || self.tuesday_mid_crew || self.wednesday_mid_crew || self.thursday_mid_crew || self.friday_mid_crew || self.saturday_mid_crew || self.sunday_mid_crew
  end

  def monday_mid_crew
    return self.mid_crew && self.mid_crew.include?('mon')
  end

  def tuesday_mid_crew
    return self.mid_crew && self.mid_crew.include?('tue')
  end

  def wednesday_mid_crew
    return self.mid_crew && self.mid_crew.include?('wen')
  end

  def thursday_mid_crew
    return self.mid_crew && self.mid_crew.include?('thu')
  end

  def friday_mid_crew
    return self.mid_crew && self.mid_crew.include?('fri')
  end

  def saturday_mid_crew
    return self.mid_crew && self.mid_crew.include?('sat')
  end

  def sunday_mid_crew
    return self.mid_crew && self.mid_crew.include?('sun')
  end


  def other_shift?
    return self.monday_other_shift || self.tuesday_other_shift || self.wednesday_other_shift || self.thursday_other_shift || self.friday_other_shift || self.saturday_other_shift || self.sunday_other_shift
  end

  def monday_other_shift
    return self.other_shift && self.other_shift.include?('mon')
  end

  def tuesday_other_shift
    return self.other_shift && self.other_shift.include?('tue')
  end

  def wednesday_other_shift
    return self.other_shift && self.other_shift.include?('wen')
  end

  def thursday_other_shift
    return self.other_shift && self.other_shift.include?('thu')
  end

  def friday_other_shift
    return self.other_shift && self.other_shift.include?('fri')
  end

  def saturday_other_shift
    return self.other_shift && self.other_shift.include?('sat')
  end

  def sunday_other_shift
    return self.other_shift && self.other_shift.include?('sun')
  end

  def kp_breakfast
    return self.kp && self.kp.count('b')
  end
  def kp_breakfast=(on)
    if on && !self.kp_breakfast
      if self.kp
        self.kp << 'b'
      else
        self.kp = 'b'
      end
    elsif !on && self.kp_breakfast
      self.kp.gsub!('b', '')
    end
  end

  def kp_lunch
    return self.kp && self.kp.count('l')
  end
  def kp_lunch=(on)
    if on && !self.kp_lunch
      if self.kp
        self.kp << 'l'
      else
        self.kp = 'l'
      end
    elsif !on && self.kp_lunch
      self.kp.gsub!('l', '')
    end
  end

  def kp_dinner
    return self.kp && self.kp.count('d')
  end
  def kp_dinner=(on)
    if on && !self.kp_dinner
      if self.kp
        self.kp << 'd'
      else
        self.kp = 'd'
      end
    elsif !on && self.kp_dinner
      self.kp.gsub!('d', '')
    end
  end

  def cook_1_breakfast
    return self.cook_1 && self.cook_1.count('b')
  end
  def cook_1_breakfast=(on)
    if on && !self.cook_1_breakfast
      if self.cook_1
        self.cook_1 << 'b'
      else
        self.cook_1 = 'b'
      end
    elsif !on && self.cook_1_breakfast
      self.cook_1.gsub!('b', '')
    end
  end

  def cook_1_lunch
    return self.cook_1 && self.cook_1.count('l')
  end
  def cook_1_lunch=(on)
    if on && !self.cook_1_lunch
      if self.cook_1
        self.cook_1 << 'l'
      else
        self.cook_1 = 'l'
      end
    elsif !on && self.cook_1_lunch
      self.cook_1.gsub!('l', '')
    end
  end

  def cook_1_dinner
    return self.cook_1 && self.cook_1.count('d')
  end
  def cook_1_dinner=(on)
    if on && !self.cook_1_dinner
      if self.cook_1
        self.cook_1 << 'd'
      else
        self.cook_1 = 'd'
      end
    elsif !on && self.cook_1_dinner
      self.cook_1.gsub!('d', '')
    end
  end

  def cook_2_breakfast
    return self.cook_2 && self.cook_2.count('b')
  end
  def cook_2_breakfast=(on)
    if on && !self.cook_2_breakfast
      if self.cook_2
        self.cook_2 << 'b'
      else
        self.cook_2 = 'b'
      end
    elsif !on && self.cook_2_breakfast
      self.cook_2.gsub!('b', '')
    end
  end

  def cook_2_lunch
    return self.cook_2 && self.cook_2.count('l')
  end
  def cook_2_lunch=(on)
    if on && !self.cook_2_lunch
      if self.cook_2
        self.cook_2 << 'l'
      else
        self.cook_2 = 'l'
      end
    elsif !on && self.cook_2_lunch
      self.cook_2.gsub!('l', '')
    end
  end

  def cook_2_dinner
    return self.cook_2 && self.cook_2.count('d')
  end
  def cook_2_dinner=(on)
    if on && !self.cook_2_dinner
      if self.cook_2
        self.cook_2 << 'd'
      else
        self.cook_2 = 'd'
      end
    elsif !on && self.cook_2_dinner
      self.cook_2.gsub!('d', '')
    end
  end

  def pre_crew_breakfast
    return self.pre_crew && self.pre_crew.count('b')
  end
  def pre_crew_breakfast=(on)
    if on && !self.pre_crew_breakfast
      if self.pre_crew
        self.pre_crew << 'b'
      else
        self.pre_crew = 'b'
      end
    elsif !on && self.pre_crew_breakfast
      self.pre_crew.gsub!('b', '')
    end
  end

  def pre_crew_lunch
    return self.pre_crew && self.pre_crew.count('l')
  end
  def pre_crew_lunch=(on)
    if on && !self.pre_crew_lunch
      if self.pre_crew
        self.pre_crew << 'l'
      else
        self.pre_crew = 'l'
      end
    elsif !on && self.pre_crew_lunch
      self.pre_crew.gsub!('l', '')
    end
  end

  def pre_crew_dinner
    return self.pre_crew && self.pre_crew.count('d')
  end
  def pre_crew_dinner=(on)
    if on && !self.pre_crew_dinner
      if self.pre_crew
        self.pre_crew << 'd'
      else
        self.pre_crew = 'd'
      end
    elsif !on && self.pre_crew_dinner
      self.pre_crew.gsub!('d', '')
    end
  end

  def crew_breakfast
    return self.crew && self.crew.count('b')
  end
  def crew_breakfast=(on)
    if on && !self.crew_breakfast
      if self.crew
        self.crew << 'b'
      else
        self.crew = 'b'
      end
    elsif !on && self.crew_breakfast
      self.crew.gsub!('b', '')
    end
  end

  def crew_lunch
    return self.crew && self.crew.count('l')
  end
  def crew_lunch=(on)
    if on && !self.crew_lunch
      if self.crew
        self.crew << 'l'
      else
        self.crew = 'l'
      end
    elsif !on && self.crew_lunch
      self.crew.gsub!('l', '')
    end
  end

  def crew_dinner
    return self.crew && self.crew.count('d')
  end
  def crew_dinner=(on)
    if on && !self.crew_dinner
      if self.crew
        self.crew << 'd'
      else
        self.crew = 'd'
      end
    elsif !on && self.crew_dinner
      self.crew.gsub!('d', '')
    end
  end

# breakfast!!
  def breakfast?
    return (self.monday_breakfast || self.tuesday_breakfast || self.wednesday_breakfast || self.thursday_breakfast || self.friday_breakfast || self.saturday_breakfast || self.sunday_breakfast)>0
  end

  def monday_breakfast
    return self.monday && self.monday.count('b')
  end
  def monday_breakfast=(on)
    if on && !self.monday_breakfast
      self.monday << 'b'
    elsif !on && self.monday_breakfast
      self.monday.gsub!('b', '')
    end
  end

  def tuesday_breakfast
    return self.tuesday && self.tuesday.count('b')
  end
  def tuesday_breakfast=(on)
    if on && !self.tuesday_breakfast
      self.tuesday << 'b'
    elsif !on && self.tuesday_breakfast
      self.tuesday.gsub!('b', '')
    end
  end

  def wednesday_breakfast
    return self.wednesday && self.wednesday.count('b')
  end
  def wednesday_breakfast=(on)
    if on && !self.wednesday_breakfast
      self.wednesday << 'b'
    elsif !on && self.wednesday_breakfast
      self.wednesday.gsub!('b', '')
    end
  end

  def thursday_breakfast
    return self.thursday && self.thursday.count('b')
  end
  def thursday_breakfast=(on)
    if on && !self.thursday_breakfast
      self.thursday << 'b'
    elsif !on && self.thursday_breakfast
      self.thursday.gsub!('b', '')
    end
  end

  def friday_breakfast
    return self.friday && self.friday.count('b')
  end
  def friday_breakfast=(on)
    if on && !self.friday_breakfast
      self.friday << 'b'
    elsif !on && self.friday_breakfast
      self.friday.gsub!('b', '')
    end
  end

  def saturday_breakfast
    return self.saturday && self.saturday.count('b')
  end
  def saturday_breakfast=(on)
    if on && !self.saturday_breakfast
      self.saturday << 'b'
    elsif !on && self.saturday_breakfast
      self.saturday.gsub!('b', '')
    end
  end

  def sunday_breakfast
    return self.sunday && self.sunday.count('b')
  end
  def sunday_breakfast=(on)
    if on && !self.sunday_breakfast
      self.sunday << 'b'
    elsif !on && self.sunday_breakfast
      self.sunday.gsub!('b', '')
    end
  end

  # lunch!!
  def lunch?
    return (self.monday_lunch || self.tuesday_lunch || self.wednesday_lunch || self.thursday_lunch || self.friday_lunch || self.saturday_lunch || self.sunday_lunch)>0
  end

  def monday_lunch
    return self.monday && self.monday.count('l')
  end
  def monday_lunch=(on)
    if on && !self.monday_lunch
      self.monday << 'l'
    elsif !on && self.monday_lunch
      self.monday.gsub!('l', '')
    end
  end

  def tuesday_lunch
    return self.tuesday && self.tuesday.count('l')
  end
  def tuesday_lunch=(on)
    if on && !self.tuesday_lunch
      self.tuesday << 'l'
    elsif !on && self.tuesday_lunch
      self.tuesday.gsub!('l', '')
    end
  end

  def wednesday_lunch
    return self.wednesday && self.wednesday.count('l')
  end
  def wednesday_lunch=(on)
    if on && !self.wednesday_lunch
      self.wednesday << 'l'
    elsif !on && self.wednesday_lunch
      self.wednesday.gsub!('l', '')
    end
  end

  def thursday_lunch
    return self.thursday && self.thursday.count('l')
  end
  def thursday_lunch=(on)
    if on && !self.thursday_lunch
      self.thursday << 'l'
    elsif !on && self.thursday_lunch
      self.thursday.gsub!('l', '')
    end
  end

  def friday_lunch
    return self.friday && self.friday.count('l')
  end
  def friday_lunch=(on)
    if on && !self.friday_lunch
      self.friday << 'l'
    elsif !on && self.friday_lunch
      self.friday.gsub!('l', '')
    end
  end

  def saturday_lunch
    return self.tuesday && self.saturday.count('l')
  end
  def saturday_lunch=(on)
    if on && !self.saturday_lunch
      self.saturday << 'l'
    elsif !on && self.saturday_lunch
      self.saturday.gsub!('l', '')
    end
  end

  def sunday_lunch
    return self.saturday && self.sunday.count('l')
  end
  def sunday_lunch=(on)
    if on && !self.sunday_lunch
      self.sunday << 'l'
    elsif !on && self.sunday_lunch
      self.sunday.gsub!('l', '')
    end
  end

  # dinner!!
  def dinner?
    return (self.monday_dinner || self.tuesday_dinner || self.wednesday_dinner || self.thursday_dinner || self.friday_dinner || self.saturday_dinner || self.sunday_dinner)>0
  end

  def monday_dinner
    return self.monday && self.monday.count('d')
  end
  def monday_dinner=(on)
    if on && !self.monday_dinner
      self.monday << 'd'
    elsif !on && self.monday_dinner
      self.monday.gsub!('d', '')
    end
  end

  def tuesday_dinner
    return self.tuesday && self.tuesday.count('d')
  end
  def tuesday_dinner=(on)
    if on && !self.tuesday_dinner
      self.tuesday << 'd'
    elsif !on && self.tuesday_dinner
      self.tuesday.gsub!('d', '')
    end
  end

  def wednesday_dinner
    return self.wednesday && self.wednesday.count('d')
  end
  def wednesday_dinner=(on)
    if on && !self.wednesday_dinner
      self.wednesday << 'd'
    elsif !on && self.wednesday_dinner
      self.wednesday.gsub!('d', '')
    end
  end

  def thursday_dinner
    return self.thursday && self.thursday.count('d')
  end
  def thursday_dinner=(on)
    if on && !self.thursday_dinner
      self.thursday << 'd'
    elsif !on && self.thursday_dinner
      self.thursday.gsub!('d', '')
    end
  end

  def friday_dinner
    return self.friday && self.friday.count('d')
  end
  def friday_dinner=(on)
    if on && !self.friday_dinner
      self.friday << 'd'
    elsif !on && self.friday_dinner
      self.friday.gsub!('d', '')
    end
  end

  def saturday_dinner
    return self.saturday && self.saturday.count('d')
  end
  def saturday_dinner=(on)
    if on && !self.saturday_dinner
      self.saturday << 'd'
    elsif !on && self.saturday_dinner
      self.saturday.gsub!('d', '')
    end
  end

  def sunday_dinner
    return self.sunday && self.sunday.count('d')
  end
  def sunday_dinner=(on)
    if on && !self.sunday_dinner
      self.sunday << 'd'
    elsif !on && self.sunday_dinner
      self.sunday.gsub!('d', '')
    end
  end
end
