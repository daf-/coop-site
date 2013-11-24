class AddCoopRefToSwapRequests < ActiveRecord::Migration
  def change
    add_reference :swap_requests, :coop, index: true
  end
end
