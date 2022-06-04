class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.string :delivery_postal_code
      t.string :delivery_address
      t.string :delivery_name
      t.integer :payment_method, default: 0
      t.integer :is_active, default: 0
      t.integer :amount_billed
      t.integer :postage

      t.timestamps
    end
  end
end
