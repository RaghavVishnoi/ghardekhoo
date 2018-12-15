module ApplicationHelper

	def categories
		ProductCategory.where(active: true).map{|category| [category.name.camelize, category.id]}
	end

end
