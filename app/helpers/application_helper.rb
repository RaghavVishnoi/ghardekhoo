module ApplicationHelper

	def categories
		ProductCategory.where(active: true).map{|category| [category.name.camelize, category.id]}
	end

	def category_types(category_id)
		if category_id.present?
			ProductSubCategory.where(product_category_id: category_id, active: true).map{|category| [category.name.camelize, category.id]}
		else
			ProductSubCategory.where(active: true).map{|category| ["#{category&.product_category&.name&.camelize} - " + category.name.camelize, category.id]}
		end
	end

end
