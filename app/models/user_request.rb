class UserRequest < ApplicationRecord

	attr_accessor :is_email_required
	attr_accessor :old_status

	belongs_to :product_category
	belongs_to :product_sub_category
	belongs_to :user
	has_many :user_request_replies

	validates :product_category, presence: true
	validates :product_sub_category, presence: true
	validates :subject, presence: true
	validates :description, presence: true

	before_update :set_email_params
	before_commit :generate_number, on: :create
	after_commit :notify_support_team, on: :create
	after_commit :notify_user, on: :update

	def status_enum
		REQUEST_STATUS
	end

	def name
		"#{number}"
	end

	private
		def set_email_params
			if status_changed? && self.old_status.present?
				self.is_email_required =  true
				self.old_status = status_was
			end
		end

		def generate_number
			self.update(number: "REQ"+(10000 + self.id).to_s, active: true)
		end

		def notify_support_team
			RequestMailer.submit_request(self).deliver_now!
		end

		def notify_user
			if self.is_email_required == true
				old_status_value = REQUEST_STATUS.select{|status| status[1] == self.old_status}.flatten.first
				new_status_value = REQUEST_STATUS.select{|status| status[1] == self.status}.flatten.first
				RequestMailer.update_request_status(old_status_value, new_status_value, self).deliver_now!
			end
		end	

end
