class AddColumnAddressToRetailerProduct < ActiveRecord::Migration[5.2]
  def change
  	add_column :retailer_products, :address, :text
  end
end
