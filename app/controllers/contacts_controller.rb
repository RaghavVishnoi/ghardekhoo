class ContactsController < ApplicationController

	def index
	end

	def faq
		@faqs = Faq.where(active: true).page(params[:page]).per(FAQ_PER_PAGE)
	end

	def about
	end

end