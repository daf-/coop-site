class AddMealTimesToCoop < ActiveRecord::Migration
  def change
    change_table :coops do |t|
      t.time :bfast_time
      t.time :lunch_time
      t.time :dinner_time
      t.string :monday
      t.string :tuesday
      t.string :wednesday
      t.string :thursday
      t.string :friday
      t.string :saturday
      t.string :sunday
    end
  end
end