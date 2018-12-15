class DropdownsController < ApplicationController

	def city_list
		@cities = CS.cities(params[:state_code] , :in)
		@default_city = @cities.include?(result.city) ? @default_city : nil
	rescue StandardError => ex		
	end

end