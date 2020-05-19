json.meta do
  json.code t('authentication.status.success')
end
json.response do
    json.user do
  		json.partial! 'api/users/v1/user', user: @user
    end
end
