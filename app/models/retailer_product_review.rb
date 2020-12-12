class RetailerProductReview < ApplicationRecord

	belongs_to :retailer_product
	belongs_to :user

end
