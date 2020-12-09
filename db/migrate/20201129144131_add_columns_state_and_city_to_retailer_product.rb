class AddColumnsStateAndCityToRetailerProduct < ActiveRecord::Migration[5.2]
  def change
  	add_column :retailer_products, :city, :string
  	add_column :retailer_products, :state, :string
  end
end
