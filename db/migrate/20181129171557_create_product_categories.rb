class CreateProductCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :product_categories do |t|
    	t.string :name
    	t.boolean :active, default: true
      t.timestamps
    end
    add_index :product_categories, :name
  end
end
