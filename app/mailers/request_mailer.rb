class RequestMailer < ApplicationMailer

	def submit_request(user_request)
		@user_request = user_request
		subject = EMAIL_SUBJECTS['submit_request']
		mail( to: ENV['NO_REPLY_EMAIL'], subject: "#{subject.gsub('@{request_number}', @user_request.number)}" )
	end 

end
