class RemoveCOnstrainOnGstNumberInRetailer < ActiveRecord::Migration[5.0]
  def change
  	change_column :retailers, :gst_number, :string, :null => true
  end
end
