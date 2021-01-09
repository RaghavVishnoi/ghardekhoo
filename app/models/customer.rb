class Customer < ApplicationRecord

	belongs_to :product_sub_category, class_name: 'ProductSubCategory', foreign_key: :product_sub_categories_id
	validates :email, presence: true
	validates :name, presence: true
	validates :phone, presence: true
	validates :product_sub_categories_id, presence: true

end
