json.meta do
  json.code t('authentication.status.success')
end
json.response do
  json.product_categories do
  		json.partial! 'category', collection: @product_categories, as: :product_category
  end
end
