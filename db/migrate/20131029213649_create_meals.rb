class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.String :type
      t.Boolean :isSpecial
      t.String :name

      t.timestamps
    end
  end
end
