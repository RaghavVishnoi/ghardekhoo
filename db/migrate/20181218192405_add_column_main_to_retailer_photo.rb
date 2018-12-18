class AddColumnMainToRetailerPhoto < ActiveRecord::Migration[5.0]
  def change
  	add_column :retailer_photos, :main, :boolean
  	add_index :retailer_photos, :main
  end
end
