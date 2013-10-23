class AddCoopRefToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :coop, index: true
  end
end
