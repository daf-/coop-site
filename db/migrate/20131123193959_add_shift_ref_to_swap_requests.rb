class AddShiftRefToSwapRequests < ActiveRecord::Migration
  def change
    add_reference :swap_requests, :shift, index: true
  end
end
