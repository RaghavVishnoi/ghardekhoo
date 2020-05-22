class RetailerProduct < ApplicationRecord
	belongs_to :retailer
	belongs_to :product_sub_category
	has_many :retailer_product_photos

	before_create :default_value

	has_many_attached :photos

	def status_enum
	  [['Pending', 0],['Approved',1],['Declined',2]]
	end

	def name
		"#{retailer.name} - #{product_name} - #{sku_code}"
	end

	def default_value
		self.status = 0
	end
	
end
