class RemoveEndTimeFromShifts < ActiveRecord::Migration
  def change
    remove_column :shifts, :end_time, :datetime
  end
end
