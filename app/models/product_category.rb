class ProductCategory < ApplicationRecord
	has_many :retailers, through: :retailer_product_categories
	has_many :retailer_product_categories
end
