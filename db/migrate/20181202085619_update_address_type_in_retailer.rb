class UpdateAddressTypeInRetailer < ActiveRecord::Migration[5.0]
  def change
  	change_column :retailers, :address, :text
  end
end
