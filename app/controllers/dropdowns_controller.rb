class DropdownsController < ApplicationController

	before_action :default_retailer, only: [:admin_city_list]
	before_action :default_advertisement, only: [:city_retailers]

	def city_list
		state = State.find_by(name: params[:name])
		if state&.cities.present?
			@cities = state.cities.where(active: true).pluck(:name)
		else
			@cities = []
		end
	rescue StandardError => ex		
	end

	def admin_city_list
		state = State.find_by(name: params[:name])
		if state&.cities.present?
			@cities = state.cities.where(active: true).pluck(:name)
		else
			@cities = []
		end
	end	

	def subcategories
		@element_id = params[:element_id]
		category_id = params[:category_id]
		@subcategories = ProductSubCategory.where(active: true, product_category_id: category_id ).pluck(:p_name, :id)
	end

	def city_retailers
		city_name = params[:city_name]
		state_name = params[:state_name]
		if city_name.present?
			# @retailers = Retailer.near("#{city_name}, #{state_code}, IN", RETAILER_NEAR_BY_RADIUS, units: :km, order: 'first_name')
			# retailer_ids = @retailers.pluck(:id)
			@retailers_count = RetailerProduct.joins(:retailer).where('retailer_products.active = ? AND retailer_products.status = ? AND LOWER(retailers.state) = ? AND LOWER(retailers.city) = ? AND retailers.active = ? AND retailers.account_status = ?', true, 1, state_name.downcase, city_name.downcase, true, 1).group_by(&:product_sub_category_id)
		else
			# Remove Geocoder api to find retailer on state
			# @retailers = Retailer.near("#{state}, IN", RETAILER_NEAR_BY_RADIUS, units: :km, order: 'first_name')
			# retailer_ids = @retailers.pluck(:id)
			@retailers_count = RetailerProduct.joins(:retailer).where('retailer_products.active = ? AND retailer_products.status = ? AND LOWER(retailers.state) = ? AND retailers.active = ? AND retailers.account_status = ?', true, 1, state_name.downcase, true, 1).group_by(&:product_sub_category_id)
		end
	end

	def nearest_location
		@result = Geocoder.search([session[:lat].to_f, session[:lng].to_f]).first
	end

	private
		def default_retailer
			if params[:retailer_id].present?
				@default_city = Retailer.find_by(id: params[:retailer_id])&.city
			end
		end

		def default_advertisement
			ad_type = AdType.find_by(name: 'WebHomeListing')
			@advertisements = Advertisement.where(active: true, ad_type_id: ad_type&.id).limit(15)
		end

end