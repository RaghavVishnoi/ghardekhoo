class AddColumnProductSubCategory < ActiveRecord::Migration[5.0]
  def change
  	add_column :retailer_products, :product_sub_category_id, :integer
  	add_foreign_key :retailer_products, :product_sub_categories
  end
end
