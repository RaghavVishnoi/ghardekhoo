class AddColumnRatingToRetailer < ActiveRecord::Migration[5.0]
  def change
  	add_column :retailers, :rating, :float
  	add_index :retailers, :rating
  end
end
