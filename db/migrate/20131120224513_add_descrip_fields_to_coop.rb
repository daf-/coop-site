class AddDescripFieldsToCoop < ActiveRecord::Migration
  def change
    add_column :coops, :public_descrip, :text
    add_column :coops, :member_descrip, :text
  end
end
