class AddColumnAccessTokenToRetailerProduct < ActiveRecord::Migration[5.2]
  def change
  	add_column :retailer_products, :access_token, :string
  end
end
