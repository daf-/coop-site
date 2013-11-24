class CreateUsages < ActiveRecord::Migration
  def connection
    @connection ||= Usage.connection
  end

  def change
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

    @connection = ActiveRecord::Base.establish_connection("#{Rails.env}").connection
  end
end
