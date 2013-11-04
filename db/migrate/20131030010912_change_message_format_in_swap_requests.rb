class ChangeMessageFormatInSwapRequests < ActiveRecord::Migration
  def change
    change_column :swap_requests, :message, :text
  end
end
