class ChangeJoinHashInCoops < ActiveRecord::Migration
  def change
    rename_column :coops, :join_hash, :admin_join_hash
  end
end
