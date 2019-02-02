class CreateRetailerReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :retailer_reviews do |t|
    	t.integer :retailer_id
    	t.integer :user_id
    	t.text :review
    	t.float :rating
        t.timestamps
    end
    add_foreign_key :retailer_reviews, :retailers
    add_foreign_key :retailer_reviews, :users
    add_index :retailer_reviews, :rating
  end
end
