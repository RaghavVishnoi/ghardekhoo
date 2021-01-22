class RetailerProduct < ApplicationRecord

	attr_accessor :product_photos
	
	belongs_to :retailer
	belongs_to :product_sub_category, -> { where(active: true) }
	belongs_to :product_type, -> { where(active: true) }
	belongs_to :product_operation, -> { where(active: true) }
	has_many :retailer_product_photos
	has_many :retailer_product_reviews

	before_create :default_value

	has_many_attached :photos

	validates :city, presence: true
	validates :state, presence: true
	validates :min_price, presence: true
	validates :product_type_id, presence: true
	validates :retailer_id, presence: true
	validates :product_operation_id, presence: true
	validates :upload_date, presence: true

	def status_enum
	  [['Pending', 0],['Approved',1],['Declined',2]]
	end

	def city_enum
    []
  end

  def state_enum
    State.pluck(:name)
  end

	def name
		"#{retailer&.name} - #{product_name} - #{sku_code}"
	end

	def default_value
		self.status = 0
		self.access_token = Token.new.generate
	end

	def retailer_state
		retailer&.state
	end

	def retailer_city
		retailer&.city
	end

	def is_retailer_active
		retailer&.active ? 'Yes' : 'No'
	end

	def product_sub_category_name
		product_sub_category&.name
	end

	def nearby_locations
		RetailerProduct.where('active = ? AND (city = ? OR state = ?) AND id != ?', true, city, state, id).order('priority asc, upload_date desc')
	end
	
end
