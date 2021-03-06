class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.text :comment
      t.string :delivery_mode
      t.string :tracking_number
      t.attachment :enclosure
      
      t.references :admin
      t.references :customer
      t.references :admin_approver

      t.boolean :approved, :default => false
      t.boolean :sent, :default => false
      t.timestamps
    end
    add_index :orders, :admin_id
    add_index :orders, :customer_id
  end
end
