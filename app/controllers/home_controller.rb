class HomeController < ApplicationController

	before_action :set_defaults, only: [:index]

	def index
		@default_category = params[:category_id]
		ad_type = AdType.find_by(name: 'WebHomeListing')
		@advertisements = Advertisement.where(active: true, ad_type_id: ad_type&.id).limit(15)
	end

	def get_location
		lat = params[:lat]
		lng = params[:lng]
		session[:lat] = lat
		session[:lng] = lng
		result = Geocoder.search([params[:lat].to_f, params[:lng].to_f]).first
		state = result.state
		@default_state = state_list.map{|states| states[1] if states[0].include?(state)}.compact.first
		@state_code = @default_state
		@categories = ProductCategory.where(active: true).order('name')
		@retailers = Retailer.near([lat, lng], RETAILER_NEAR_BY_RADIUS, units: :km, order: 'first_name').pluck(:id)		
		@retailers_count = RetailerProduct.where(active: true, status: 1, retailer_id: @retailers).group_by(&:product_sub_category_id)
	rescue StandardError => ex	
		@categories = ProductCategory.where(active: true).order('name')
		@retailers_count = RetailerProduct.where(active: true).group_by(&:product_sub_category_id)
	end

	private	
		def set_defaults
			state_list
			city_list
		end

		def state_list
			@states = CS.states(:in).map{|h| [h[1],h[0]]}
	  end

	  def city_list
	  	@cities = CS.cities(@state_code , :in)
	  end

end
