class Errors
 class << self

 	def customize(error_messages)
 		errors = []
 		error_messages.each do |error_message|
 			custom_error_message = error_message.split('^')[1]
 			if custom_error_message.blank?
 				errors << error_message
 			else
 				errors << custom_error_message
 			end
 		end
 		errors
 	end

 end
end