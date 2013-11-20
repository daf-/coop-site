class Shift < ActiveRecord::Base
  belongs_to :coop
  has_and_belongs_to_many :users
  has_and_belongs_to_many :meals

  def isLeader
  end

  def isLeader=(checkbox)
  end

  def self.makeForMealsOnDay(daynum, meals, params, coop, old_shifts)
    meal = meals.first.meal_type
    days = ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday']
    day = days[daynum]
    activities = {}
    params.each_key do |key|
      if key.include? "_#{meal}"
        act = key.gsub("_#{meal}", "")
        unless days.include? act
          activities[act] = false
        end
      end
    end

    new_shifts = []
    destroy_shifts = []
    if (old_shifts)
      old_shifts.each do |shift|
        if activities[shift.activity]
          new_shifts << shift
          activities[shift.activity] = true
        else
          destroy_shifts << shift
        end
      end
    end

    destroy_shifts.each do |shift|
      shift.destroy
    end

    new_shifts.each do |shift|
      shift.meals = meals
    end

    out = []
    activities.each_pair do |activity, exists|
      out << activity
      unless exists
        shift = Shift.create(day: day, coop: coop, activity: activity)
        out << shift
        shift.meals = meals
      end
    end
    puts out.inspect
  end
end
