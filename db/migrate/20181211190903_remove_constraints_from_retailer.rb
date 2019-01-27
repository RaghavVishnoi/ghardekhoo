class RemoveConstraintsFromRetailer < ActiveRecord::Migration[5.0]
  def change
  	remove_index :retailers,column: :gst_number,uniq: true
  end
end
