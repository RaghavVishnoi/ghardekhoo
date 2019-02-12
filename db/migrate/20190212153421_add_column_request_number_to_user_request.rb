class AddColumnRequestNumberToUserRequest < ActiveRecord::Migration[5.0]
  def change
  	add_column :user_requests, :number, :string
  end
end
