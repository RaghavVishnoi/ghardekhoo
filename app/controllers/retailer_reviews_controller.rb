class RetailerReviewsController < ApplicationController

	def  create
		@retailer_review = RetailerReview.find_or_initialize_by(
			retailer_id: retailer_review_params[:retailer_id],
			user_id: current_user.id
		)
		if @retailer_review.update(retailer_review_params)
			redirect_to request.referrer
		else
			flash[:error] = @retailer_review.errors.full_messages
		end
	end

	private
		def retailer_review_params
			params.require(:retailer_review).permit(:retailer_id, :review, :rating)
		end		

end