class AddColumnAttachmentIdToRetailerPhoto < ActiveRecord::Migration[5.2]
  def change
  	add_column :retailer_photos, :attachment_id, :integer
  	add_column :retailer_product_photos, :attachment_id, :integer
  	add_column :advertisements, :attachment_id, :integer
  end
end
