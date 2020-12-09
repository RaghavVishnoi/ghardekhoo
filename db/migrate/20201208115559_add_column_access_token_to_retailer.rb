class AddColumnAccessTokenToRetailer < ActiveRecord::Migration[5.2]
  def change
  	add_column :retailers, :access_token, :string
  end
end
