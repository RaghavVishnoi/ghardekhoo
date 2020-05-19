class AddColumnUsernameToRetailer < ActiveRecord::Migration[5.0]
  def change
  	add_column :retailers, :username, :string
  end
end
