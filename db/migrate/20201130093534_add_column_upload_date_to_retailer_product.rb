class AddColumnUploadDateToRetailerProduct < ActiveRecord::Migration[5.2]
  def change
  	add_column :retailer_products, :upload_date, :datetime
  end
end
