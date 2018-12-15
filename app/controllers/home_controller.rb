class HomeController < ApplicationController

	before_action :set_defaults, only: [:index]
	before_action :state_list, only: [:index]
	before_action :city_list, only: [:index]


	def index
	end

	def get_location
		lat = params[:lat]
		lng = params[:lng]
		session[:lat] = lat
		session[:lng] = lng
		result = Geocoder.search([params[:lat].to_f, params[:lng].to_f]).first
		state = result.state
		@default_state = state_list.map{|states| states[1] if states[0] == state}.compact.first
		@state_code = @default_state
	rescue StandardError => ex	
	end

	private	
		def set_defaults
			@categories = ProductCategory.where(active: true).order('name')
			@retailers_count = retailers_count
		end

		def retailers_count
			RetailerProduct.where(active: true).group_by(&:product_sub_category_id)
		end

		def state_list
			@states = CS.states(:in).map{|h| [h[1],h[0]]}
	  end

	  def city_list
	  	@cities = CS.cities(@state_code , :in)
	  end

end
