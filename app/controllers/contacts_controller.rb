class ContactsController < ApplicationController

	def index
	end

	def faq
		@faqs = Faq.where(active: true).page(params[:page]).per(FAQ_PER_PAGE)
	end

	def about
		@product_sub_categories = ProductSubCategory.where(active: true).uniq
	end

end
