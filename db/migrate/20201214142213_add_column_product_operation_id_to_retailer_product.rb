class AddColumnProductOperationIdToRetailerProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :retailer_products, :product_operation_id, :integer
    add_foreign_key :retailer_products, :product_operations
  end
end
