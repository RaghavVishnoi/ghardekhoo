class CreateRetailerProductCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :retailer_product_categories do |t|
    	t.integer :retailer_id
    	t.integer :product_category_id
      t.timestamps
    end
    add_foreign_key :retailer_product_categories, :retailers
    add_foreign_key :retailer_product_categories, :product_categories
  end
end
