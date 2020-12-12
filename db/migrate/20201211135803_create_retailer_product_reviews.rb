class CreateRetailerProductReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :retailer_product_reviews do |t|
    	t.string :review
    	t.float :rating
    	t.integer :retailer_product_id
    	t.integer :user_id
      t.timestamps
    end
    add_foreign_key :retailer_product_reviews, :retailer_products
    add_foreign_key :retailer_product_reviews, :users
  end
end
