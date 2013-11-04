class Meal < ActiveRecord::Base

  belongs_to :coop

  def self.generate_meals_for_coop(coop_params, coop)
    end_of_fall = Date.new(Date.today.year, 12, 31)
    end_of_spring = Date.new(Date.today.year, 5, 30)
    curdate = Date.today
    puts curdate.wday
    puts coop_params.inspect
    curdate < end_of_spring ? end_date = end_of_spring : end_date = end_of_fall
    # iterate through each day until end_date
    while curdate < end_date
      case curdate.wday
      when 0
        if coop_params['sunday_breakfast']
          Meal.create_meal(curdate, coop_params['bfast_time'], 'breakfast', coop)
        end
        if coop_params['sunday_lunch']
          Meal.create_meal(curdate, coop_params['lunch_time'], 'lunch', coop)
        end
        if coop_params['sunday_dinner']
          Meal.create_meal(curdate, coop_params['dinner_time'], 'dinner', coop)
        end
      when 1
        if coop_params['monday_breakfast']
          Meal.create_meal(curdate, coop_params['bfast_time'], 'breakfast', coop)
        end
        if coop_params['monday_lunch']
          Meal.create_meal(curdate, coop_params['lunch_time'], 'lunch', coop)
        end
        if coop_params['monday_dinner']
          Meal.create_meal(curdate, coop_params['dinner_time'], 'dinner', coop)
        end
      when 2
        if coop_params['tuesday_breakfast']
          Meal.create_meal(curdate, coop_params['bfast_time'], 'breakfast', coop)
        end
        if coop_params['tuesday_lunch']
          Meal.create_meal(curdate, coop_params['lunch_time'], 'lunch', coop)
        end
        if coop_params['tuesday_dinner']
          Meal.create_meal(curdate, coop_params['dinner_time'], 'dinner', coop)
        end
      when 3
        if coop_params['wednesday_breakfast']
          Meal.create_meal(curdate, coop_params['bfast_time'], 'breakfast', coop)
        end
        if coop_params['wednesday_lunch']
          Meal.create_meal(curdate, coop_params['lunch_time'], 'lunch', coop)
        end
        if coop_params['wednesday_dinner']
          Meal.create_meal(curdate, coop_params['dinner_time'], 'dinner', coop)
        end
      when 4
        if coop_params['thursday_breakfast']
          Meal.create_meal(curdate, coop_params['bfast_time'], 'breakfast', coop)
        end
        if coop_params['thursday_lunch']
          Meal.create_meal(curdate, coop_params['lunch_time'], 'lunch', coop)
        end
        if coop_params['thursday_dinner']
          Meal.create_meal(curdate, coop_params['dinner_time'], 'dinner', coop)
        end
      when 5
        if coop_params['friday_breakfast']
          Meal.create_meal(curdate, coop_params['bfast_time'], 'breakfast', coop)
        end
        if coop_params['friday_lunch']
          Meal.create_meal(curdate, coop_params['lunch_time'], 'lunch', coop)
        end
        if coop_params['friday_dinner']
          Meal.create_meal(curdate, coop_params['dinner_time'], 'dinner', coop)
        end
      when 6
        if coop_params['saturday_breakfast']
          Meal.create_meal(curdate, coop_params['bfast_time'], 'breakfast', coop)
        end
        if coop_params['saturday_lunch']
          Meal.create_meal(curdate, coop_params['lunch_time'], 'lunch', coop)
        end
        if coop_params['saturday_dinner']
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
      start_time = Time.parse(start_time)
      puts start_time.hour
      time = DateTime.new(curdate.year, curdate.month, curdate.day, start_time.hour, start_time.min)
      Meal.create start_time: time, meal_type: meal_type, isSpecial: false, end_time: time + Rational(1, 24), coop: coop
    end
end
