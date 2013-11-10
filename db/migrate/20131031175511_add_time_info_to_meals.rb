class AddTimeInfoToMeals < ActiveRecord::Migration
  def change
    change_table :meals do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :meal_info
      t.string :discussion_info
    end
  end
end
