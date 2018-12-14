class AddColumnDescriptionToRetailerProduct < ActiveRecord::Migration[5.0]
  def change
  	add_column :retailer_products, :description, :text
  end
end
