class AddHeadCookToMeal < ActiveRecord::Migration
  def change
    add_column :meals, :head_cook, :integer
  end
end
