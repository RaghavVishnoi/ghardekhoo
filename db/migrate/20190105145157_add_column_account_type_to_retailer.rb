class AddColumnAccountTypeToRetailer < ActiveRecord::Migration[5.0]
  def change
  	add_column :retailers, :account_type, :string
  end
end
