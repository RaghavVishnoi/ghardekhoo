class ChangeColumnTypeForLocationInRetailer < ActiveRecord::Migration[5.0]
  def change
  	change_column :retailers, :lng, 'numeric USING CAST(lng AS numeric)'
  	change_column :retailers, :lat, 'numeric USING CAST(lat AS numeric)'
  end
end
