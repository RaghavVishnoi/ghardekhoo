json.meta do
  json.code t('authentication.status.success')
end
json.response do
	json.product_count @current_user&.retailer_products.where(active: true).count
  json.product do
  		json.partial! 'product', product: @retailer_product
  end
end
