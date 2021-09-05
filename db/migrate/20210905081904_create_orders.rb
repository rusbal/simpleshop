class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :shipping_address, null: false
      t.integer :total, null: false
      t.datetime :paid_at

      t.timestamps
    end
  end
end
