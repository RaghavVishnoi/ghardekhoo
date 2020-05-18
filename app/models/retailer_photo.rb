class RetailerPhoto < ApplicationRecord

	after_destroy :remove_storage

	belongs_to :retailer
	attr_accessor :photo

	scope :main_photo, -> { where(main: true) } 

	def photo
		"#{photo_url}"
	end

	private
		def remove_storage
			if UPLOAD_FILE_LIB == 'active_storage'
				attachment = ActiveStorage::Attachment.find_by(id: self.attachment_id)
				return if attachment.blank?
				attachment.blob.purge
				attachment.purge
			elsif UPLOAD_FILE_LIB == 'aws'	
				# Need to call remove file method 
			end	
		end

end
