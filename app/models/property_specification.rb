class PropertySpecification < ApplicationRecord

	belongs_to :retailer_product

	before_validation do |model|
	  model.other_rooms.reject!(&:blank?)
	end

	validates :bedrooms, presence: { message: '^ Please select no of bedrooms.' }
	validates :bathrooms, presence: { message: '^ Please select no of bathrooms.' }
	validates :balconies, presence: { message: '^ Please select no of balconies.' }
	validates :furnishing, presence: { message: '^ Please select furnishing.' }
	validates :covered_parking, presence: { message: '^ Please select no of covered parkings.' }
	validates :open_parking, presence: { message: '^ Please select no of open parkings.' }
	validates :availability_status, presence: { message: '^ Please select availability.' }
	validates :possession_by_year, presence: { message: '^ Please select possession year.' }
	validates :possession_by_month, presence: { message: '^ Please select possession month' }
	validates :ownership, presence: { message: '^ Please select ownership.' }

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
