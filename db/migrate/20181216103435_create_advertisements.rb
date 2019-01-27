class CreateAdvertisements < ActiveRecord::Migration[5.0]
  def change
    create_table :advertisements do |t|
    	t.integer :retailer_id
    	t.integer :ad_type_id
    	t.boolean :active, default: true
      t.timestamps
    end
    add_foreign_key :advertisements, :retailers
    add_foreign_key :advertisements, :ad_types
  end
end
