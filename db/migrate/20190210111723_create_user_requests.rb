class CreateUserRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :user_requests do |t|
    	t.integer :product_category_id
    	t.integer :product_sub_category_id
    	t.string  :subject
    	t.text    :description
    	t.integer :user_id
        t.timestamps
    end
    add_foreign_key :user_requests, :product_categories
    add_foreign_key :user_requests, :product_sub_categories
    add_foreign_key :user_requests, :users
  end
end
