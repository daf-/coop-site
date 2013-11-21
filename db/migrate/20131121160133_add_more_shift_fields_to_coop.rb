class AddMoreShiftFieldsToCoop < ActiveRecord::Migration
  def change
    add_column :coops, :commando, :string, :default => ''
    add_column :coops, :mid_crew, :string, :default => ''
    add_column :coops, :other_shift_name, :string, :default => ''
    add_column :coops, :other_shift, :string, :default => ''
    add_column :coops, :commando_time, :time
    add_column :coops, :mid_crew_time, :time
    add_column :coops, :other_shift_time, :time
  end
end
