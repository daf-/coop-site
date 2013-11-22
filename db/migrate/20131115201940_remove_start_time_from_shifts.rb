class RemoveStartTimeFromShifts < ActiveRecord::Migration
  def change
    remove_column :shifts, :start_time, :datetime
  end
end
