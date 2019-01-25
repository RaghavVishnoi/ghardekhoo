module ApplicationHelper
	
	def message_type(name)
	    set_name = name.present? ? name.to_s : ''
	    case set_name
	    when 'error'
	      'danger'
	    when 'info'
	      'info'
	    else
	      'success'
	    end
	end

	def list_states
		CS.get(:IN).values
	end

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

	def web_banners
		ad_type = AdType.find_by(name: 'WebBanner')
		ad_type.advertisements.where(active: true)
	end

end
