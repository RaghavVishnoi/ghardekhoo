class AddColumnProductTypeIdToRetailerProduct < ActiveRecord::Migration[5.2]
  def change
  	add_column :retailer_products, :product_type_id, :integer
  	add_foreign_key :retailer_products, :product_types
  end
end
