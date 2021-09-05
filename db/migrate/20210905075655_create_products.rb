class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.references :region, null: false, foreign_key: true
      t.string :title, null: false
      t.string :description, null: false
      t.string :image_url, null: false
      t.integer :price, null: false
      t.string :sku, null: false
      t.integer :stock, null: false, default: 0

      t.timestamps
    end
  end
end
