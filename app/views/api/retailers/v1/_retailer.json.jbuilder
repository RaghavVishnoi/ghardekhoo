json.id retailer.id
json.gst_number retailer.gst_number
json.adhaar_number retailer.adhaar_number
json.pan_number retailer.pan_number
json.first_name retailer.first_name
json.last_name retailer.last_name
json.phone retailer.phone
json.email retailer.email
json.photo_url retailer.photo_url
json.address retailer.address
json.city retailer.city
json.state retailer.state
json.country retailer.country
json.lat retailer.lat
json.lng retailer.lng
json.token retailer.token
json.account_type retailer.account_type
category = retailer.try(:product_categories)&.first
json.category do
	json.id category&.id
	json.name category&.name
end
json.product_count retailer.retailer_products.where(active: true).count
json.product_categories do
	product_categories = retailer.try(:product_categories).map{|category| category.product_sub_categories.where(active: true)}.flatten
	json.partial! 'api/v1/product_categories/sub_category', collection: product_categories, as: :product_sub_category
end
json.employee retailer.try(:employee).try(:name) || ""
json.photos do
	json.partial! 'api/retailers/v1/photo', collection: retailer.retailer_photos, as: :photo
end
