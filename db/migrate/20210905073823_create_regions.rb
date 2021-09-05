class CreateRegions < ActiveRecord::Migration[6.0]
  def change
    create_table :regions do |t|
      t.string :title, null: false
      t.string :country, null: false
      t.string :currency, null: false
      t.integer :tax, null: false

      t.timestamps
    end
  end
end
