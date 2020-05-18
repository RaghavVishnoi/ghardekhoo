class State < ApplicationRecord

	has_many :cities
	has_many :retailers, class_name: 'Retailer', foreign_key: :state

end
