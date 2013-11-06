class Meal < ActiveRecord::Base

  belongs_to :coop

  def day
    days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
    days[start_time.to_date.wday]
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
      start_time = Time.parse(start_time)
      time = DateTime.new(curdate.year, curdate.month, curdate.day, start_time.hour, start_time.min)
      old_date = DateTime.new(curdate.year, curdate.month, curdate.day)
      old_meal = Meal.where(meal_type: meal_type, isSpecial: false, coop: coop, start_time: old_date).first
      if old_meal
        old_meal[:start_time] = time
        old_meal[:end_time] = time + Rational(1, 24)
        old_meal.save
      else
        Meal.create start_time: time, meal_type: meal_type, isSpecial: false, end_time: time + Rational(1, 24), coop: coop
      end
    end
end
