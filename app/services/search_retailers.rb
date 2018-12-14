class SearchRetailers

	def initialize(params)
		@params = params
		@retailers = Retailer.where(active: true)
	end

	def result
		@retailers
	end

end