class CreateUserRequestReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :user_request_replies do |t|
      t.integer :user_request_id
      t.integer :user_id
      t.integer :admin_id
      t.string :replied_by
      t.text :description
      t.timestamps
    end
    add_foreign_key :user_request_replies, :user_requests
  	add_foreign_key :user_request_replies, :users
    add_foreign_key :user_request_replies, :admins
  end

end
