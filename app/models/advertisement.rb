class Advertisement < ApplicationRecord
	belongs_to :retailer
	belongs_to :ad_type
end
