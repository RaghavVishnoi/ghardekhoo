class HomeController < ApplicationController

	before_action :set_defaults, only: [:index]

	def index
	end

	private	
		def set_defaults
			@categories = ProductCategory.where(active: true).order('name')
			@retailers_count = retailers_count
		end

		def retailers_count
			RetailerProduct.where(active: true).group_by(&:product_sub_category_id)
		end

end
