class DropdownsController < ApplicationController

	before_action :nearest_location

	def city_list
		@cities = CS.cities(params[:state_code] , :in)
		@default_city = @result.city
	rescue StandardError => ex		
	end

	def city_retailers
		city_name = params[:city_name]
		state_code = params[:state_code]
		@categories = ProductCategory.where(active: true).order('name')
		if city_name.present?
			@retailers = Retailer.near("#{city_name}, #{state_code}, IN", RETAILER_NEAR_BY_RADIUS, units: :km, order: 'first_name')
			retailer_ids = @retailers.pluck(:id)
			@retailers_count = RetailerProduct.where(active: true, retailer_id: retailer_ids).group_by(&:product_sub_category_id)
		else
			@retailers = Retailer.where(active: true)
			retailer_ids = @retailers.pluck(:id)
			@retailers_count = RetailerProduct.where(active: true, retailer_id: retailer_ids).group_by(&:product_sub_category_id)
		end
		ad_type = AdType.find_by(name: 'WebHomeListing')
		@advertisements = Advertisement.where(active: true, retailer_id: retailer_ids, ad_type_id: ad_type&.id).limit(15)
	end

	def nearest_location
		@result = Geocoder.search([session[:lat].to_f, session[:lng].to_f]).first
	end

end