class PropertySpecification < ApplicationRecord

	belongs_to :retailer_product

	before_validation do |model|
	  model.other_rooms.reject!(&:blank?)
	end

	def bedrooms_enum
		ROOM_COUNTS
	end

	def bathrooms_enum
		ROOM_COUNTS
	end

	def balconies_enum
		ROOM_COUNTS
	end

	def other_rooms_enum
		OTHER_ROOMS
	end

	def furnishing_enum
		FURNISHING
	end

	def covered_parking_enum
		PARKING_COUNTS
	end

	def open_parking_enum
		PARKING_COUNTS
	end

	def availability_status_enum
		AVAILABILITY_STATUS
	end

	def possession_by_year_enum
		POSSESSION_BY_YEAR
	end

	def possession_by_month_enum
		Date::MONTHNAMES.compact
	end

	def ownership_enum
		['Freehold', 'Leasehold', 'Co-operative Society', 'Power of Attorney']
	end

end
