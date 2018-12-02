class AddColumnTokenToRetailer < ActiveRecord::Migration[5.0]
  def change
  	add_column :retailers, :token, :string
  end
end
