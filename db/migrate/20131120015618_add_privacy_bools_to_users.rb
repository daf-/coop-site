class AddPrivacyBoolsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :display_email, :boolean
    add_column :users, :display_phone, :boolean
  end
end
