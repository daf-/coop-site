class AddUserReferenceToMeals < ActiveRecord::Migration
  def change
    add_reference :meals, :user, index: true
  end
end
