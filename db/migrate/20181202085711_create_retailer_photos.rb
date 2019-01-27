class CreateRetailerPhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :retailer_photos do |t|
    	t.string  :photo_url
    	t.string  :lat
    	t.string  :lng
    	t.integer :retailer_id
      t.timestamps
    end
    add_foreign_key :retailer_photos, :retailers
  end
end
