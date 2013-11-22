class AddDayToShifts < ActiveRecord::Migration
  def change
    add_column :shifts, :day, :string
  end
end
