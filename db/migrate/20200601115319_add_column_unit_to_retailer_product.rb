class AddColumnUnitToRetailerProduct < ActiveRecord::Migration[5.2]
  def change
  	add_column :retailer_products, :unit, :string
  end
end
