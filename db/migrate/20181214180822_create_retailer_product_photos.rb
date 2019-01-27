class CreateRetailerProductPhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :retailer_product_photos do |t|
    	t.string :photo_url
    	t.string :lat
    	t.string :lng
    	t.integer :retailer_product_id
      t.timestamps
    end
    add_foreign_key :retailer_product_photos, :retailer_products
  end
end
