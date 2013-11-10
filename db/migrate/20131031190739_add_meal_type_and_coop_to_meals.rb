class AddMealTypeAndCoopToMeals < ActiveRecord::Migration
  def change
    add_reference :meals, :coop, index: true
    rename_column :meals, :type, :meal_type
  end
end
