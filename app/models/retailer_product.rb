class RetailerProduct < ApplicationRecord
	
	attr_accessor :state
	attr_accessor :city

	belongs_to :retailer
	belongs_to :product_sub_category
	has_many :retailer_product_photos

	before_create :default_value

	has_many_attached :photos

	def status_enum
	  [['Pending', 0],['Approved',1],['Declined',2]]
	end

	def name
		"#{retailer&.name} - #{product_name} - #{sku_code}"
	end

	def default_value
		self.status = 0
	end

	def retailer_state
		retailer&.state
	end

	def retailer_city
		retailer&.city
	end

	def is_retailer_active
		retailer&.active ? 'Yes' : 'No'
	end
	
end
