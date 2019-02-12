class AddColumnActiveToUserRequest < ActiveRecord::Migration[5.0]
  def change
  	add_column :user_requests, :active, :boolean, default: false
  end
end
