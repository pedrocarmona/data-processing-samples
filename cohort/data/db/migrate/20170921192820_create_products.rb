class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.references :user, foreign_key: true
      t.string :name, null: false, default: ""
      t.timestamp :added_on
      t.timestamps null: false
    end
    add_index :products, :added_on
  end
end
