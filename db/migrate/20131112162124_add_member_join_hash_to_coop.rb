class AddMemberJoinHashToCoop < ActiveRecord::Migration
  def change
    add_column :coops, :member_join_hash, :string
  end
end
