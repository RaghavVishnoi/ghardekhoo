class AddColumnStatusToUserRequest < ActiveRecord::Migration[5.0]
  def change
  	add_column :user_requests, :status, :integer
  end
end
