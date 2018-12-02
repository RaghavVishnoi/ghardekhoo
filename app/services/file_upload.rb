require 'aws-sdk'
class FileUpload

	def upload(file_path, file)
		s3 = Aws::S3::Resource.new(
			credentials: Aws::Credentials.new(ENV['AWS_KEY_ID'], ENV['AWS_SECRET_KEY']),
			region: ENV['REGION']
		)
		Rails.logger.info "Uploading file.."
		file_path = file_path+"/"+file.original_filename
		obj = s3.bucket(ENV['BUCKET_NAME']).object(file_path)
		result = obj.upload_file(file.path, acl:'public-read')
		Rails.logger.info "Uploaded File"
		if result
			{status: 200,file_name: file.original_filename,file_url: obj.public_url,file_type: file.content_type}
		else
			{status: 422,message: 'Something went wrong on file upload!'}
		end
	rescue StandardError => e
		Rails.logger.info "Error upload file -- #{e.message}"
		{status: 500,message: e.message}
	end			

end