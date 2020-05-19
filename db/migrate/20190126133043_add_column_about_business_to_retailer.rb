class AddColumnAboutBusinessToRetailer < ActiveRecord::Migration[5.0]
  def change
  	add_column :retailers, :about_business, :text
  end
end
