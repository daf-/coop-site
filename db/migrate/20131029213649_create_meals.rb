class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :type
      t.boolean :isSpecial
      t.string :name

      t.timestamps
    end
  end
end
