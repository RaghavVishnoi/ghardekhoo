class Api::V1::UsersController < Api::Users::ApisController

	def banner
		ad_type = AdType.find_by(name: 'CustomerAppBanner')
		@banners = Advertisement.where(active: true, ad_type_id: ad_type&.id)
		render template: 'api/v1/users/banner.json.jbuilder'
	end

end
