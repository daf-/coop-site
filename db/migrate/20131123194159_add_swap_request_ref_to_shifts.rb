class AddSwapRequestRefToShifts < ActiveRecord::Migration
  def change
    add_reference :shifts, :swap_request, index: true
  end
end
