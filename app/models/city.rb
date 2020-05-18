class City < ApplicationRecord

	belongs_to :state
	has_many :retailers, class_name: 'Retailer', foreign_key: :city

end
