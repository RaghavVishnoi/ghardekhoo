class CreateProductSubCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :product_sub_categories do |t|
    	t.string :name
    	t.boolean :active, default: true
    	t.integer :product_category_id
      t.timestamps
    end
    add_foreign_key :product_sub_categories, :product_categories
  end
end
