class AddColumnProductSubCategoryIdToCustomer < ActiveRecord::Migration[5.2]
  def change
  	add_reference :customers, :product_sub_categories
  end
end
