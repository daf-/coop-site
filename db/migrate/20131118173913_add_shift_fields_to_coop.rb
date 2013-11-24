class AddShiftFieldsToCoop < ActiveRecord::Migration
  def change
    add_column :coops, :kp, :string
    add_column :coops, :cook_1, :string
    add_column :coops, :cook_2, :string
    add_column :coops, :pre_crew, :string
    add_column :coops, :crew, :string
    add_column :coops, :custom_shift_1_b, :string
    add_column :coops, :custom_shift_1_l, :string
    add_column :coops, :custom_shift_1_d, :string
    add_column :coops, :custom_shift_2_b, :string
    add_column :coops, :custom_shift_2_l, :string
    add_column :coops, :custom_shift_2_d, :string
    add_column :coops, :custom_shift_3_b, :string
    add_column :coops, :custom_shift_3_l, :string
    add_column :coops, :custom_shift_3_d, :string
  end
end
