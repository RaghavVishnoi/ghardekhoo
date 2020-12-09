class AddColumnPriorityToRetailerProduct < ActiveRecord::Migration[5.2]
  def change
  	add_column :retailer_products, :priority, :integer
  	add_column :retailer_products, :main, :boolean, default: false
  end
end
