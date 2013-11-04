class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.integer :coop_id
      t.datetime :start_time
      t.datetime :end_time
      t.string :activity
      t.integer :leader

      t.timestamps
    end
  end
end
