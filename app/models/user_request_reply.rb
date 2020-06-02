class UserRequestReply < ApplicationRecord

	belongs_to :user_request
	belongs_to :user
	belongs_to :admin

	validates :description, presence: true

	after_commit :notify_receiver, on: :create

	def name
		if replied_by == 'user'
			"#{user.name} - #{created_at&.strftime('%m-%d-%y %H:%M')}"
		else
			"Support Team - #{created_at&.strftime('%m-%d-%y %H:%M')}"
		end
	end

	private
		def notify_receiver
			if self.replied_by == 'user'
				RequestMailer.user_reply(self).deliver_now!
			else
				RequestMailer.support_reply(self).deliver_now!
			end
		end

end
