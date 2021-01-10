class AddColumnDescriptionToCustomer < ActiveRecord::Migration[5.2]
  def change
  	add_column :customers, :description, :text
  end
end
