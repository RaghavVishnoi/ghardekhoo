class ProductCategory < ApplicationRecord
	has_many :retailers, through: :retailer_product_categories
	has_many :retailer_product_categories, dependent: :destroy
	has_many :product_sub_categories
end
