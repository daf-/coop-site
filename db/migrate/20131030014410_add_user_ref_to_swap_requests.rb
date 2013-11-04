class AddUserRefToSwapRequests < ActiveRecord::Migration
  def change
    add_reference :swap_requests, :user, index: true
  end
end
