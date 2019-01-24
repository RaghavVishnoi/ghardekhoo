class AddColumnGoogleIdToUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :google_user_id, :string
  end
end
