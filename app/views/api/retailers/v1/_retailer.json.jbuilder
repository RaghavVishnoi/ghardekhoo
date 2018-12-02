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
json.categories retailer.try(:product_categories).pluck(:name).join(',')
json.employee retailer.try(:employee).try(:name) || ""
json.photos do
	json.partial! 'api/retailers/v1/photo', collection: retailer.retailer_photos, as: :photo
end
