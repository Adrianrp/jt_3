class AddBooleanToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :confirmed, :boolean, default: false
  end
end
