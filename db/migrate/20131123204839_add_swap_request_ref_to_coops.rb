class AddSwapRequestRefToCoops < ActiveRecord::Migration
  def change
    add_reference :coops, :swap_request, index: true
  end
end
