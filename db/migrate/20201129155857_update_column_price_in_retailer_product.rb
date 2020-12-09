class UpdateColumnPriceInRetailerProduct < ActiveRecord::Migration[5.2]
  def change
  	rename_column :retailer_products, :price, :min_price
  	add_column :retailer_products, :max_price, :integer
  end
end
