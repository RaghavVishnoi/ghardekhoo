class Search::Products

	def initialize(params)
		@params = params
		@retailer_products = RetailerProduct.includes(:product_sub_category, :retailer_product_photos).where(active: true, status: 1)
	end

	def fetch_records
		search_by_subcategory if @params[:sub_category_id].present?
		serach_by_state if @params[:state].present?
		search_by_city if @params[:city].present?
		search_by_min_price if @params[:min_price].present?
		search_by_max_price if @params[:max_price].present?
		search_by_product_type if @params[:product_types].present?
		search_by_dealer_name if @params[:dealer_name].present?
		@retailer_products
	end

	def search_by_subcategory
		sub_category_ids = @params[:sub_category_id].split(',')
		@retailer_products = @retailer_products.where(product_sub_category_id: sub_category_ids)
	end

	def serach_by_state
		@retailer_products = @retailer_products.where('LOWER(retailer_products.state) = ?', @params[:state].downcase)
	end

	def search_by_city
		@retailer_products = @retailer_products.where('LOWER(retailer_products.city) = ?', @params[:city].downcase)
	end

	def search_by_min_price
		min_price = @params[:min_price].gsub(',', '')
		@retailer_products = @retailer_products.where('max_price >= ?', min_price)
	end

	def search_by_max_price
		max_price = @params[:max_price].gsub(',', '')
		@retailer_products = @retailer_products.where('min_price <= ?', max_price)
	end

	def search_by_product_type
		product_type_ids = @params[:product_types].split(',')
		@retailer_products = @retailer_products.where(product_type_id: product_type_ids)
	end

	def search_by_dealer_name
		@retailer_products = @retailer_products.joins(:retailer).where('LOWER(retailers.first_name) like ? OR LOWER(retailers.last_name) like ?', "%#{@params[:dealer_name].downcase}%", "%#{@params[:dealer_name].downcase}%")
	end

end