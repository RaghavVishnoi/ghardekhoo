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
		CS.get(:IN).values.sort
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

	def retailer_address(retailer)
		"#{retailer.address}, " + "#{retailer.city}, " + "#{retailer.state}, " + "#{retailer.country}"
	end

	def retailer_product_sub_categories(retailer)
		retailer_products = retailer.retailer_products.where(active: true)
		if retailer_products.present?
			retailer_products.map{|retailer_product| retailer_product.product_sub_category}.pluck(:name)
		else
			[]
		end
	end

	def profile_advertisement
		ad_type = AdType.find_by(name: 'ProfilePage')
		ad_type.advertisements.where(active: true).first
	end

	def retailer_products(retailer)
		retailer.retailer_products.where(active: true, status: 1)
	end

end
