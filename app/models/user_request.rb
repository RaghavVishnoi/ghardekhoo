class UserRequest < ApplicationRecord

	belongs_to :product_category
	belongs_to :product_sub_category
	belongs_to :user

	validates :subject, presence: true
	validates :description, presence: true

	before_commit :generate_number, on: :create

	def status_enum
		REQUEST_STATUS
	end

	private
		def generate_number
			self.update(number: "GREQ"+(000 + self.id).to_s, active: true)
		end

end
