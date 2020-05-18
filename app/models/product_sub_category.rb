class ProductSubCategory < ApplicationRecord
	belongs_to :product_category
	has_many :retailer_products

	def name
		"#{self&.p_name} [#{product_category&.name&.camelize}]"
	end

end
