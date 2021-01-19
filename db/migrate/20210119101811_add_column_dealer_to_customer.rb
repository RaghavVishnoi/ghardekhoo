class AddColumnDealerToCustomer < ActiveRecord::Migration[5.2]
  def change
  	add_column :customers, :dealer, :boolean, default: false
  end
end
