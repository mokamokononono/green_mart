class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name,                 null: false
      t.integer :price,               null: false
      t.text :description,            null: false
      t.integer :category_id,         null: false
      t.integer :condition_id,        null: false
      t.integer :pesticides_id,       null: false
      t.float :amount,                null: false
      t.integer :stock,               null: false
      t.integer :shipping_charge_id,  null: false
      t.integer :shipping_source_id,  null: false
      t.integer :shipping_date_id,    null: false
      t.references :user,             foreign_key: true
      t.timestamps
    end
  end
end
