json.meta do
  json.code t('authentication.status.success')
end
json.response do
  json.retailer do
  		json.partial! 'api/retailers/v1/retailer', retailer: @retailer
  end
end
