class Meal < ActiveRecord::Base

  belongs_to :coop
  has_and_belongs_to_many :shifts
  belongs_to :user

  include TimeHelper

  def day
    days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
    days[start_time.to_date.wday]
  end

  def irreg_time
    field_name = self.meal_type
    if field_name == 'breakfast'
      field_name = 'bfast'
    end
    field_name << '_time'
    calendarTime(self.start_time) != calendarTime(self.coop[field_name])
  end

  def self.delete_all(type, coop)
    default_meals = Meal.where(coop: coop, meal_type: type, name: nil) # nil name implies that it was a regularly sched meal
    default_meals.each do |meal|
      if meal.shifts
        meal.shifts.each do |shift|
          shift.swap_requests.each do |sr|
            sr.destroy
          end
          shift.destroy
        end
      end
      meal.destroy
    end
  end

  def self.makeMeals(type, params, coop)
    end_of_fall = Date.new(Date.today.year, 12, 31)
    end_of_spring = Date.new(Date.today.year, 5, 30)
    days = ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday']
    curdate = Date.today
    curdate < end_of_spring ? end_date = end_of_spring : end_date = end_of_fall
    meals = {}
    shifts = {}
    (0..6).each do |daynum|
      meals[daynum] = []
      shifts[daynum] = []
    end

    while curdate < end_date
      if (params[days[curdate.wday]+'_'+type])
        meal = Meal.update_meal(curdate, params['time'], type, coop)
        meals[curdate.wday] << meal
        shifts[curdate.wday] = meal.shifts
      end
      curdate = curdate.next_day
    end

    (0..6).each do |daynum|
      if meals[daynum].length > 0
        Shift.makeForMealsOnDay(daynum, meals[daynum], params, coop, shifts[daynum])
      else
        Meal.deleteMealsForDay(type, daynum)
      end
    end
  end

  def self.deleteMealsForDay(type, daynum)
    Meal.where(meal_type: type).each do |meal|
      if (meal.start_time.strftime('%w') == daynum.to_s)
        if meal.shifts
          meal.shifts.each do |shift|
            shift.swap_requests.each do |sr|
              sr.destroy
            end
            shift.destroy
          end
        end
        meal.destroy
      end
    end
  end

  def date
    self.start_time.to_date
  end

  def date=(a_date)
    a_date = Date.parse(a_date)
    oldstart = self.start_time || DateTime.now
    oldend = self.end_time || DateTime.now
    self.start_time = DateTime.new(a_date.year, a_date.month, a_date.day, oldstart.hour, oldstart.min)
    self.end_time = DateTime.new(a_date.year, a_date.month, a_date.day, oldend.hour, oldend.min)
  end

  def start_time_no_date
    self.start_time.to_time
  end

  def start_time_no_date=(time)
    unless self.start_time
      self.start_time = DateTime.now
    end
    self.start_time = DateTime.new(self.start_time.year, self.start_time.month, self.start_time.day, time.hour, time.min)
  end

  def end_time_no_date
    self.end_time.to_time
  end

  def end_time_no_date=(time)
    unless self.end_time
      self.end_time = DateTime.now
    end
    self.end_time = DateTime.new(self.end_time.year, self.end_time.month, self.end_time.day, time.hour, time.min)
  end

  def from_params(params)
    new_params = {}
    params.each do | key, value |
      if key.count('(') == 0 && value && value.length > 0
        # has no parens in key name
        new_params[key] = value
      end
    end
    new_params[:start_time_no_date] = Meal.time_from_select(params['start_time_no_date(4i)'], params['start_time_no_date(5i)'])
    new_params
  end

  private

    def self.time_from_select(hours, mins)
      Time.parse("#{hours}:#{mins}").utc
    end

    def self.create_meal(curdate, start_time, meal_type, coop)
      time = DateTime.new(curdate.year, curdate.month, curdate.day, start_time.hour, start_time.min)
      Meal.create start_time: time, meal_type: meal_type, isSpecial: false, end_time: time + Rational(1, 24), coop: coop
    end
    def self.update_meal(curdate, start_time, meal_type, coop)
      time = DateTime.new(curdate.year, curdate.month, curdate.day, start_time.hour, start_time.min)
      old_date_bod = DateTime.new(curdate.year, curdate.month, curdate.day,0,0,0)
      old_date_eod = DateTime.new(curdate.year, curdate.month, curdate.day,23,59,59)
      new_meal = {}
      old_meal = Meal.where(meal_type: meal_type, isSpecial: false, coop: coop, start_time: old_date_bod..old_date_eod).first
      if old_meal
        new_meal = old_meal
        old_meal[:start_time] = time
        old_meal[:end_time] = time + Rational(1, 24)
        old_meal.save
      else
        new_meal = Meal.create start_time: time, meal_type: meal_type, isSpecial: false, end_time: time + Rational(1, 24), coop: coop
      end
      new_meal
    end
end
