class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.bigint :seller_id
      t.bigint :buyer_id
      t.timestamp :timestamp
      t.timestamps null: false
    end
    add_index :orders, :buyer_id
    add_index :orders, :seller_id
    add_index :orders, :timestamp
  end
end
