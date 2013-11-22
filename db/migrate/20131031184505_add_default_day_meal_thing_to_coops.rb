class AddDefaultDayMealThingToCoops < ActiveRecord::Migration
  def change
      change_column :coops, :sunday, :string, :default => ''
      change_column :coops, :monday, :string, :default => ''
      change_column :coops, :tuesday, :string, :default => ''
      change_column :coops, :wednesday, :string, :default => ''
      change_column :coops, :thursday, :string, :default => ''
      change_column :coops, :friday, :string, :default => ''
      change_column :coops, :saturday, :string, :default => ''
  end
end
