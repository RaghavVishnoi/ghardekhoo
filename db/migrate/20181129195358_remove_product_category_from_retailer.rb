class RemoveProductCategoryFromRetailer < ActiveRecord::Migration[5.0]
  def change
  	remove_column :retailers, :product_category_id
  end
end
