class CreateUsages < ActiveRecord::Migration

  def connection
    Usage.connection
  end
  def up
    create_table :usages do |t|
      t.integer :user_id
      t.datetime :when
      t.string :controller
      t.string :action
      t.string :ip_addr
      t.string :path
      t.integer :coop_id
      t.boolean :admin

      t.timestamps
    end
  end

  def down
    drop_table :usages
  end
end
