class RetailerProductReviewsController < ApplicationController

	def  create
		@retailer_product_review = RetailerProductReview.find_or_initialize_by(
			retailer_product_id: retailer_product_review_params[:retailer_product_id],
			user_id: current_user.id
		)
		if @retailer_product_review.update(retailer_product_review_params)
			redirect_to request.referrer
		else
			flash[:error] = @retailer_product_review.errors.full_messages
		end
	end

	private
		def retailer_product_review_params
			params.require(:retailer_product_review).permit(:retailer_product_id, :review, :rating)
		end		

end