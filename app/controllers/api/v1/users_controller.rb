class Api::V1::UsersController < Api::Users::ApisController

	def banner
		ad_type = AdType.find_by(name: 'CustomerAppBanner')
		@banners = Advertisement.where(active: true, ad_type_id: ad_type&.id)
		render template: 'api/v1/users/banner.json.jbuilder'
	end

	def search
		retailer_name = params[:retailer_name]
		sub_category_id = params[:sub_category_id]
		category_id = params[:category_id]
		@retailers = nearby_retailers
		@retailers = @retailers.joins(:retailer_products).where('retailer_products.product_sub_category_id = ? AND status = ?', sub_category_id, 1) if sub_category_id.present?
		@retailers = @retailers.joins(:product_categories).where('product_categories.id = ?', category_id) if category_id.present? && sub_category_id.blank?
		@retailers = @retailers.where('LOWER(first_name) like ? OR LOWER(last_name) like ?', "%#{retailer_name.downcase}%", "%#{retailer_name.downcase}%") if retailer_name.present?
		@retailers = @retailers.order('rating desc, first_name asc').page(params[:page]).per(RETAILERS_PER_PAGE)
		render json: { meta: { code: t('authentication.status.success'), response: {retailers: @retailers.as_json( :include => [:retailer_reviews => {include: :user}], methods: [:categories, :sub_categories] )} } }	
	rescue StandardError => ex	
		render json: { meta: { code: t('authentication.status.unprocessible_entity'), errorDetail: ex.message } }	
	end

	private
		def nearby_retailers
			radius = params[:radius] || RETAILER_NEAR_BY_RADIUS
			# Check if the lat and lon is provided
			lat = params[:lat]
			lng = params[:lng]
			Retailer.near(
				[lat, lng], 
				radius, 
				units: :km
			).where(account_status: 1) if params[:lat].present? && params[:lng].present?

		end


end
