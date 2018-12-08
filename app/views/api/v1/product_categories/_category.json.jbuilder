json.id product_category.id
json.name product_category.name
json.product_sub_categories do
	if product_category.product_sub_categories.present?
		json.partial! 'sub_category', collection: product_category.product_sub_categories.where(active: true), as: :product_sub_category
	else
		[]
	end	
end