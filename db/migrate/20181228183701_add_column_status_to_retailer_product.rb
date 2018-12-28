class AddColumnStatusToRetailerProduct < ActiveRecord::Migration[5.0]
  def change
  	add_column :retailer_products, :status, :integer, default: 0
  	add_index :retailer_products, :status
  end
end
