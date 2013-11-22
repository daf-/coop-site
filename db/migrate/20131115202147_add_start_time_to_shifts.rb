class AddStartTimeToShifts < ActiveRecord::Migration
  def change
    add_column :shifts, :start_time, :time
  end
end
