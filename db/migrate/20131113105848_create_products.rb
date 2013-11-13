class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :image_id
      t.string :title
      t.text :description
      t.decimal :price, precision: 8, scale: 2
      t.integer :category_id

      t.timestamps
    end
  end
end
