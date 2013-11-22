class AddJoinHashToCoop < ActiveRecord::Migration
  def change
    add_column :coops, :join_hash, :string
  end
end
