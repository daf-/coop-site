class AddPicToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pic, :boolean
  end
end
