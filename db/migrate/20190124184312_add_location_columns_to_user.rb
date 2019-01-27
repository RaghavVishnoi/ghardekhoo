class AddLocationColumnsToUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :lat, :float
  	add_column :users, :lng, :float
  	add_column :users, :username, :string
  end
end
