class Shift < ActiveRecord::Base
  belongs_to :coop
  has_and_belongs_to_many :users
  has_and_belongs_to_many :meals
  has_one :swap_request

  def isLeader
  end

  def isLeader=(checkbox)
  end

  def headCook
    hc = nil
    if self.leader && (self.activity == 'cook_1' || self.activity == 'cook_2' || self.activity == 'cook')
      hc = User.find(self.leader)
    end
    hc
  end

  def pic
    pic = nil
    if self.leader && !self.headCook?
      pic = User.find(self.leader)
    end
    pic
  end

  def niceTitle
    activities = {'kp' => 'Kitchen Prep', 'cook_1' => 'First Hour Cook', 'cook_2' => 'Second Hour Cook', 'pre_crew' => 'Pre-Crew', 'crew' => 'Crew'}
    puts self.activity
    puts activities
    puts activities.has_key?self.activity
    title = self.day.capitalize
    if self.meals && self.meals.first
      title << ' ' + self.meals.first.meal_type.capitalize
    end
    title << ' ' + (activities[self.activity] ? activities[self.activity] : self.activity.capitalize)
    title
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
