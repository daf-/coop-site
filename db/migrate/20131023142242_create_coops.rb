class CreateCoops < ActiveRecord::Migration
  def change
    create_table :coops do |t|
      t.string :name

      t.timestamps
    end
  end
end
