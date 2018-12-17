class RetailerPhoto < ApplicationRecord

	belongs_to :retailer
	attr_accessor :photo

	def photo
		"#{photo_url}"
	end

end
