class CreateSwapRequests < ActiveRecord::Migration
  def change
    create_table :swap_requests do |t|
      t.boolean :headcook_required
      t.string :message
      t.datetime :date
      t.boolean :isResolved?

      t.timestamps
    end
  end
end
