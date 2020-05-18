class RenameColumnNameInProductSubCategory < ActiveRecord::Migration[5.0]
  def change
  	rename_column :product_sub_categories, :name, :p_name
  end
end
