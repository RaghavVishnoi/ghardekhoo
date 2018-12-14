class UpdateTypeForPriceInRetailerProduct < ActiveRecord::Migration[5.0]
  def change
  	change_column :retailer_products, :price, 'numeric USING CAST(price AS numeric)'
  end
end
