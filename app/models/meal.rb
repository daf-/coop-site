class Meal < ActiveRecord::Base

  belongs_to :coop

  def day
    days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
    days[start_time.to_date.wday]
  end

  def date
    self.start_time.to_date
  end

  def date=(a_date)
    a_date = Date.parse(a_date)
    oldstart = self.start_time
    oldend = self.end_time
    self.start_time = DateTime.new(a_date.year, a_date.month, a_date.day, oldstart.hour, oldstart.min)
    self.end_time = DateTime.new(a_date.year, a_date.month, a_date.day, oldend.hour, oldend.min)
  end

  def start_time_no_date
    self.start_time.to_time
  end

  def start_time_no_date=(time)
    time = Time.parse(time).utc
    unless self.start_time
      self.start_time = DateTime.now
    end
    self.start_time = DateTime.new(self.start_time.year, self.start_time.month, self.start_time.day, time.hour, time.min)
  end

  def end_time_no_date
    self.end_time.to_time
  end

  def end_time_no_date=(time)
    time = Time.parse(time).utc
    unless self.end_time
      self.end_time = DateTime.now
    end
    self.end_time = DateTime.new(self.end_time.year, self.end_time.month, self.end_time.day, time.hour, time.min)
  end

  def self.update_meals_for_coop(coop_params, coop)
    end_of_fall = Date.new(Date.today.year, 12, 31)
    end_of_spring = Date.new(Date.today.year, 5, 30)
    curdate = Date.today
    curdate < end_of_spring ? end_date = end_of_spring : end_date = end_of_fall
    # iterate through each day until end_date
    while curdate < end_date
      case curdate.wday
      when 0
        if coop_params[:sunday_breakfast] == '1'
          Meal.update_meal(curdate, coop_params['bfast_time'], 'breakfast', coop)
        end
        if coop_params[:sunday_lunch] == '1'
          Meal.update_meal(curdate, coop_params['lunch_time'], 'lunch', coop)
        end
        if coop_params[:sunday_dinner] == '1'
          Meal.update_meal(curdate, coop_params['dinner_time'], 'dinner', coop)
        end
      when 1
        if coop_params[:monday_breakfast] == '1'
          Meal.update_meal(curdate, coop_params['bfast_time'], 'breakfast', coop)
        end
        if coop_params[:monday_lunch] == '1'
          Meal.update_meal(curdate, coop_params['lunch_time'], 'lunch', coop)
        end
        if coop_params[:monday_dinner] == '1'
          Meal.update_meal(curdate, coop_params['dinner_time'], 'dinner', coop)
        end
      when 2
        if coop_params[:tuesday_breakfast] == '1'
          Meal.update_meal(curdate, coop_params['bfast_time'], 'breakfast', coop)
        end
        if coop_params[:tuesday_lunch] == '1'
          Meal.update_meal(curdate, coop_params['lunch_time'], 'lunch', coop)
        end
        if coop_params[:tuesday_dinner] == '1'
          Meal.update_meal(curdate, coop_params['dinner_time'], 'dinner', coop)
        end
      when 3
        if coop_params[:wednesday_breakfast] == '1'
          Meal.update_meal(curdate, coop_params['bfast_time'], 'breakfast', coop)
        end
        if coop_params[:wednesday_lunch] == '1'
          Meal.update_meal(curdate, coop_params['lunch_time'], 'lunch', coop)
        end
        if coop_params[:wednesday_dinner] == '1'
          Meal.update_meal(curdate, coop_params['dinner_time'], 'dinner', coop)
        end
      when 4
        if coop_params[:thursday_breakfast] == '1'
          Meal.update_meal(curdate, coop_params['bfast_time'], 'breakfast', coop)
        end
        if coop_params[:thursday_lunch] == '1'
          Meal.update_meal(curdate, coop_params['lunch_time'], 'lunch', coop)
        end
        if coop_params[:thursday_dinner] == '1'
          Meal.update_meal(curdate, coop_params['dinner_time'], 'dinner', coop)
        end
      when 5
        if coop_params[:friday_breakfast] == '1'
          Meal.update_meal(curdate, coop_params['bfast_time'], 'breakfast', coop)
        end
        if coop_params[:friday_lunch] == '1'
          Meal.update_meal(curdate, coop_params['lunch_time'], 'lunch', coop)
        end
        if coop_params[:friday_dinner] == '1'
          Meal.update_meal(curdate, coop_params['dinner_time'], 'dinner', coop)
        end
      when 6
        if coop_params[:saturday_breakfast] == '1'
          Meal.update_meal(curdate, coop_params['bfast_time'], 'breakfast', coop)
        end
        if coop_params[:saturday_lunch] == '1'
          Meal.update_meal(curdate, coop_params['lunch_time'], 'lunch', coop)
        end
        if coop_params[:saturday_dinner] == '1'
          Meal.update_meal(curdate, coop_params['dinner_time'], 'dinner', coop)
        end
      else
        # wut
      end
      curdate = curdate.next_day
    end
  end

  def self.generate_meals_for_coop(coop_params, coop)
    end_of_fall = Date.new(Date.today.year, 12, 31)
    end_of_spring = Date.new(Date.today.year, 5, 30)
    curdate = Date.today
    curdate < end_of_spring ? end_date = end_of_spring : end_date = end_of_fall
    # iterate through each day until end_date
    while curdate < end_date
      case curdate.wday
      when 0
        if coop_params[:sunday_breakfast] == '1'
          Meal.create_meal(curdate, coop_params['bfast_time'], 'breakfast', coop)
        end
        if coop_params[:sunday_lunch] == '1'
          Meal.create_meal(curdate, coop_params['lunch_time'], 'lunch', coop)
        end
        if coop_params[:sunday_dinner] == '1'
          Meal.create_meal(curdate, coop_params['dinner_time'], 'dinner', coop)
        end
      when 1
        if coop_params[:monday_breakfast] == '1'
          Meal.create_meal(curdate, coop_params['bfast_time'], 'breakfast', coop)
        end
        if coop_params[:monday_lunch] == '1'
          Meal.create_meal(curdate, coop_params['lunch_time'], 'lunch', coop)
        end
        if coop_params[:monday_dinner] == '1'
          Meal.create_meal(curdate, coop_params['dinner_time'], 'dinner', coop)
        end
      when 2
        if coop_params[:tuesday_breakfast] == '1'
          Meal.create_meal(curdate, coop_params['bfast_time'], 'breakfast', coop)
        end
        if coop_params[:tuesday_lunch] == '1'
          Meal.create_meal(curdate, coop_params['lunch_time'], 'lunch', coop)
        end
        if coop_params[:tuesday_dinner] == '1'
          Meal.create_meal(curdate, coop_params['dinner_time'], 'dinner', coop)
        end
      when 3
        if coop_params[:wednesday_breakfast] == '1'
          Meal.create_meal(curdate, coop_params['bfast_time'], 'breakfast', coop)
        end
        if coop_params[:wednesday_lunch] == '1'
          Meal.create_meal(curdate, coop_params['lunch_time'], 'lunch', coop)
        end
        if coop_params[:wednesday_dinner] == '1'
          Meal.create_meal(curdate, coop_params['dinner_time'], 'dinner', coop)
        end
      when 4
        if coop_params[:thursday_breakfast] == '1'
          Meal.create_meal(curdate, coop_params['bfast_time'], 'breakfast', coop)
        end
        if coop_params[:thursday_lunch] == '1'
          Meal.create_meal(curdate, coop_params['lunch_time'], 'lunch', coop)
        end
        if coop_params[:thursday_dinner] == '1'
          Meal.create_meal(curdate, coop_params['dinner_time'], 'dinner', coop)
        end
      when 5
        if coop_params[:friday_breakfast] == '1'
          Meal.create_meal(curdate, coop_params['bfast_time'], 'breakfast', coop)
        end
        if coop_params[:friday_lunch] == '1'
          Meal.create_meal(curdate, coop_params['lunch_time'], 'lunch', coop)
        end
        if coop_params[:friday_dinner] == '1'
          Meal.create_meal(curdate, coop_params['dinner_time'], 'dinner', coop)
        end
      when 6
        if coop_params[:saturday_breakfast] == '1'
          Meal.create_meal(curdate, coop_params['bfast_time'], 'breakfast', coop)
        end
        if coop_params[:saturday_lunch] == '1'
          Meal.create_meal(curdate, coop_params['lunch_time'], 'lunch', coop)
        end
        if coop_params[:saturday_dinner] == '1'
          Meal.create_meal(curdate, coop_params['dinner_time'], 'dinner', coop)
        end
      else
        # wut
      end
      curdate = curdate.next_day
    end
  end

  private
    def self.create_meal(curdate, start_time, meal_type, coop)
      start_time = Time.parse(start_time).utc
      time = DateTime.new(curdate.year, curdate.month, curdate.day, start_time.hour, start_time.min)
      Meal.create start_time: time, meal_type: meal_type, isSpecial: false, end_time: time + Rational(1, 24), coop: coop
    end
    def self.update_meal(curdate, start_time, meal_type, coop)
      start_time = Time.parse(start_time).utc
      time = DateTime.new(curdate.year, curdate.month, curdate.day, start_time.hour, start_time.min)
      old_date_bod = DateTime.new(curdate.year, curdate.month, curdate.day,0,0,0)
      old_date_eod = DateTime.new(curdate.year, curdate.month, curdate.day,23,59,59)
      old_meal = Meal.where(meal_type: meal_type, isSpecial: false, coop: coop, start_time: old_date_bod..old_date_eod).first
      puts old_meal
      if old_meal
        old_meal = old_meal
        old_meal[:start_time] = time
        old_meal[:end_time] = time + Rational(1, 24)
        old_meal.save
      else
        Meal.create start_time: time, meal_type: meal_type, isSpecial: false, end_time: time + Rational(1, 24), coop: coop
      end
    end
end
