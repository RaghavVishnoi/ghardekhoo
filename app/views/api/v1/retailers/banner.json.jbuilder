json.meta do
  json.code t('authentication.status.success')
end
json.response do
  json.banners do
  		json.partial! 'images', collection: @banners, as: :banner
  end
end
