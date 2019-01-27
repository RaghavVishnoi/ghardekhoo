json.meta do
  json.code t('authentication.status.success')
end
json.response do
  json.product do
  		json.partial! 'product', product: @retailer_product
  end
end
