class RetailersController < ApplicationController

	def upload
		errors = []
		file = params[:retailer_data]
		spreadsheet = open_spreadsheet(file)
		retailer_information_sheet = spreadsheet.sheet('RetailerInformation')
		retailer_information_sheet.drop(1).each do |retailer_data|
			retailer = Retailer.new(gst_number: retailer_data[0])
			set_retailer_attributes(retailer, retailer_data)
			retailer.save(validate: false)
		end
		# product_information_sheet = spreadsheet.sheet('ProductInformation')
		# product_information_sheet.drop(1).each do |product_data|
		# 	retailer = Retailer.find_by(gst_number: product_data[0])
		# 	if retailer.blank?
		# 		errors << [product_data[0], "Product", "Missing retailer on product"]
		# 	else
		#   	product = RetailerProduct.find_by(sku_code: product_data[2], retailer_id: retailer.try(:id))
		#   	product = RetailerProduct.new(sku_code: product_data[2], retailer_id: retailer.try(:id)) if product.blank?
		#   	set_product_information(product, product_data)
		#   	product.save!
		#   end
		# end
		flash[:success] = "Successfully uploaded!"
		create_error_file(errors)
		@redirect_url = admin_retailer_upload_retailers_path
	rescue StandardError => ex
		errors << ["Internal Server", "Retailer", ex.message[0..300]]
		flash[:error] = ex.message
		create_error_file(errors)
		@redirect_url = admin_retailer_upload_retailers_path
	end

	private
		def open_spreadsheet(file)
		  case File.extname(file.original_filename)
		  when ".xlsx","xls","csv" then Roo::Excelx.new(file.path)
		  else raise "Unknown file type: #{file.original_filename}"
		  end
		end

		def set_retailer_attributes(retailer, retailer_data)
			category = ProductCategory.find_by('LOWER(name) = ?', retailer_data[7].downcase)
			retailer.adhaar_number = retailer_data[1]
			retailer.pan_number = retailer_data[2]
			retailer.first_name = retailer_data[3]
			retailer.last_name = retailer_data[4]
			retailer.phone = retailer_data[6]
			retailer.email = retailer_data[5]
			retailer.retailer_product_categories.new(product_category_id: category.try(:id))
			retailer.address = retailer_data[9]
			retailer.city = retailer_data[10]
			retailer.state = retailer_data[11]
			retailer.country = retailer_data[12]
			retailer.lat = retailer_data[13]
			retailer.lng = retailer_data[14]
			employee = Employee.find_by(id: retailer_data[15])
			retailer.employee_id = employee.try(:id)
		end

		def set_product_information(product, product_data)
			product.product_name = product_data[1]
			product.active = true
		end

		def create_error_file(errors)
			if errors.present?
				require "csv"
				data = CSV.generate(headers: true) do |csv|
					csv << ["GSTNumber", "EntityName", "ErrorMessage"]
					errors.each do |error|
						csv << error
					end
		    end
		    send_data data, filename: "UploadErrors.csv"
		  end
		end

end