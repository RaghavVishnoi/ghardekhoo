class Api::V1::ProductCategoriesController < ApplicationController

	def index
		@product_categories = ProductCategory.where(active: true).all.order('name').select(:id, :name)
		render template: 'api/v1/product_categories/index.json.jbuilder'
	end

end 