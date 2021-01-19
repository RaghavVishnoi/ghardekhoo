class Customer < ApplicationRecord

	attr_accessor :retailer_id

	belongs_to :product_sub_category, class_name: 'ProductSubCategory', foreign_key: :product_sub_categories_id, optional: true
	validates :email, presence: true
	validates :name, presence: true
	validates :phone, presence: true

end
