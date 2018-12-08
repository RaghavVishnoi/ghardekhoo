class RetailerProduct < ApplicationRecord
	belongs_to :retailer
	belongs_to :product_sub_category
end
