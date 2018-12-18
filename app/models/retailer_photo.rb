class RetailerPhoto < ApplicationRecord

	belongs_to :retailer
	attr_accessor :photo

	scope :main_photo, -> { where(main: true) } 

	def photo
		"#{photo_url}"
	end

end
