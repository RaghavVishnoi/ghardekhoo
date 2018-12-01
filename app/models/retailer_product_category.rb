class RetailerProductCategory < ApplicationRecord
	belongs_to :retailer
	belongs_to :product_category

	validates  :product_category_id, :uniqueness => { :scope => :retailer_id }
end
