module ApplicationHelper

	def categories
		ProductCategory.where(active: true)
	end

end
