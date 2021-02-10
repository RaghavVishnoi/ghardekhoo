class CreatePropertySpecifications < ActiveRecord::Migration[5.2]
  def change
    create_table :property_specifications do |t|
      t.integer :bedrooms
      t.integer :bathrooms
      t.integer :balconies
      t.string :other_rooms, array: true, default: []
      t.string :furnishing
      t.integer :covered_parking
      t.integer :open_parking
      t.string :availability_status
      t.string :possession_by_year
      t.string :possession_by_month
      t.string :ownership
      t.integer :retailer_product_id
      t.timestamps
    end
    add_foreign_key :property_specifications, :retailer_products
  end
end
