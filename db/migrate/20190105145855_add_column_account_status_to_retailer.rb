class AddColumnAccountStatusToRetailer < ActiveRecord::Migration[5.0]
  def change
  	add_column :retailers, :account_status, :integer, default: 0
  end
end
