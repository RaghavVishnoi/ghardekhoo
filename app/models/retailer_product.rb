class RetailerProduct < ApplicationRecord
	belongs_to :retailer
	belongs_to :product_sub_category
	has_many :retailer_product_photos, dependent: :destroy

	attr_accessor :photos

	def name
		"#{product_name} - #{sku_code}"
	end
	
end
