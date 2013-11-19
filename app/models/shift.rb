class Shift < ActiveRecord::Base
  belongs_to :coop
  has_and_belongs_to_many :users
  has_and_belongs_to_many :meals

  def isLeader
  end

  def isLeader=(checkbox)
  end

  def self.makeForMeals(meals, params, coop, old_shifts)
    meal = meals.first.meal_type
    days = ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday']
    activities = {}
    params.each_key do |key|
      if key.include? "_#{meal}"
        act = key.gsub("_#{meal}", "")
        unless days.include? act
          activities[act] = {}
          days.each do |day|
            if (params[day+'_'+meal])
              activities[key.gsub("_#{meal}", "")][day] = false
            end
          end
        end
      end
    end

    new_shifts = []
    destroy_shifts = []
    if (old_shifts)
      old_shifts.each do |shift|
        if activities[shift.activity] && activities[shift.activity][shift.day]
          new_shifts << shift
          activities[shift.activity][day] = true
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

    activities.each_pair do |activity, hash_days|
      hash_days.each_pair do |day, exists|
        unless exists
          shift = Shift.create(day: day, coop: coop, activity: activity)
          shift.meals = meals
        end
      end
    end
  end
end
