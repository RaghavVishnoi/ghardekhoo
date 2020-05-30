class UserRequest < ApplicationRecord

	belongs_to :product_category
	belongs_to :product_sub_category
	belongs_to :user

	validates :product_category, presence: true
	validates :product_sub_category, presence: true
	validates :subject, presence: true
	validates :description, presence: true

	before_commit :generate_number, on: :create
	after_commit :notify_support_team

	def status_enum
		REQUEST_STATUS
	end

	private
		def generate_number
			self.update(number: "REQ"+(10000 + self.id).to_s, active: true)
		end

		def notify_support_team
			RequestMailer.submit_request(self).deliver_now!
		end

end
