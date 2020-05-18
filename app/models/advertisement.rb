class Advertisement < ApplicationRecord
	belongs_to :retailer
	belongs_to :ad_type

	attr_accessor :photos

	has_one_attached :photos
end
