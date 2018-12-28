class RetailerProductPhoto < ApplicationRecord
	belongs_to :retailer_product

	def photo
		"#{photo_url}"
	end
end
