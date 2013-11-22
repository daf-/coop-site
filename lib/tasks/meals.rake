namespace :meal do
  desc "delete meals from previous semester"
  task remove_old: :environment do
    Meal.where("start_time < ?", Date.today).each do |meal|
      if meal.destroy
        puts "destroyed old meal in #{meal.coop.name} at #{meal.start_time}"
      end
    end
  end
end