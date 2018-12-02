class Api::V1::ProductCategoriesController < ApplicationController

	def index
		@product_categories = ProductCategory.all.order('name').select(:id, :name)
		render json: {product_categories: @product_categories}
	end

end 