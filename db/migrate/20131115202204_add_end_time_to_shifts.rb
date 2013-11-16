class AddEndTimeToShifts < ActiveRecord::Migration
  def change
    add_column :shifts, :end_time, :time
  end
end
