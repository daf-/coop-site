class AddCancelledToMeals < ActiveRecord::Migration
  def change
    add_column :meals, :cancelled, :boolean
  end
end
