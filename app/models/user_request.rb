class UserRequest < ApplicationRecord

	belongs_to :product_category
	belongs_to :product_sub_category
	belongs_to :user

	validates :subject, presence: true
	validates :description, presence: true

	def status_enum
		REQUEST_STATUS
	end

end
