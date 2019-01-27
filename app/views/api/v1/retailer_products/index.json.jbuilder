json.meta do
  json.code t('authentication.status.success')
end
json.response do
  json.products do
  		json.partial! 'product', collection: @retailer_products, as: :product
  end
end
