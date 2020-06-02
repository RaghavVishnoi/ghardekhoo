class RequestMailer < ApplicationMailer

	def submit_request(user_request)
		@user_request = user_request
		subject = EMAIL_SUBJECTS['submit_request']
		mail( to: ENV['NO_REPLY_EMAIL'], subject: "#{subject.gsub('@{request_number}', @user_request.number)}" )
	end 

	def update_request_status(old_status_value, new_status_value, user_request)
		@old_status_value = old_status_value
		@new_status_value = new_status_value
		@user_request = user_request
		subject = EMAIL_SUBJECTS['update_request_status']
		mail( to: user_request&.user&.email, subject: "#{subject.gsub('@{request_number}', @user_request.number)}" )
	end

	def user_reply(user_request_reply)
		@user_request_reply = user_request_reply
		subject = EMAIL_SUBJECTS['user_reply']
		mail( to: ENV['NO_REPLY_EMAIL'], subject: "#{subject.gsub('@{request_number}', @user_request_reply.user_request.number).gsub('@{user_name}', @user_request_reply&.user_request&.user&.name)}" )
	end

	def support_reply(user_request_reply)
		@user_request_reply = user_request_reply
		subject = EMAIL_SUBJECTS['support_reply']
		mail( to: ENV['NO_REPLY_EMAIL'], subject: "#{subject.gsub('@{request_number}', @user_request_reply.user_request.number).gsub('@{user_name}', @user_request_reply&.user_request&.user&.name)}" )
	end

end
