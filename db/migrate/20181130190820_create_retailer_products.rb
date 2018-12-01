class CreateRetailerProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :retailer_products do |t|
    	t.string :sku_code
    	t.string :product_name
    	t.string :price
    	t.integer :retailer_id
    	t.boolean :active
      t.timestamps
    end
    add_foreign_key :retailer_products, :retailers
  end
end
