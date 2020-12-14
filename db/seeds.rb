# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

employee_roles = [
	{name: 'App User'}, {name: 'Marketing Manager'}, {name: 'Sales Manager'}, {name: 'Office Assitent'}, {name: 'Backend Support'}, {name: 'Customer Care Executive'}, {name: 'Marketing Officer'}, {name: 'Sales Rep'}
]

product_categories = [
	{name: 'All Residentials'},
	{name: 'All Commentials'}
]

employee_roles.each do |employee_role|
	Role.find_or_create_by(employee_role)
end

product_categories.each do |product_category|
	category = ProductCategory.find_or_create_by(product_category)
	case product_category[:name]
	when 'All Residentials'
		category.product_sub_categories.find_or_create_by(p_name: 'Residential Apartment')
		category.product_sub_categories.find_or_create_by(p_name: 'Independent House/Villa')
		category.product_sub_categories.find_or_create_by(p_name: 'Plot')
		category.product_sub_categories.find_or_create_by(p_name: 'Flat')
		category.product_sub_categories.find_or_create_by(p_name: 'Other')
	when 'All Commentials'
		category.product_sub_categories.find_or_create_by(p_name: 'Ready to move office space')
		category.product_sub_categories.find_or_create_by(p_name: 'Bare shell office space')
	end
end

ad_types = [
	{name: 'WebHomeListing'}, 
	{name: 'WebBanner'}, 
	{name: 'HomeWebSlide'}, 
	{name: 'ListWebSlide'}, 
	{name: 'ProfilePage'},
	{name: 'WebFooterAds'}
]

ad_types.each do |ad_type|
	AdType.find_or_create_by(name: ad_type[:name], active: true)
end

# states_list = {:AN=>"Andaman and Nicobar Islands", :AP=>"Andhra Pradesh", :AR=>"Arunachal Pradesh", :AS=>"Assam", :BR=>"Bihar", :CH=>"Chandigarh", :CT=>"Chhattisgarh", :DD=>"Daman and Diu", :DL=>"Delhi", :DN=>"Dadra and Nagar Haveli", :GA=>"Goa", :GJ=>"Gujarat", :HP=>"Himachal Pradesh", :HR=>"Haryana", :JH=>"Jharkhand", :JK=>"Kashmir", :KA=>"Karnataka", :KL=>"Kerala", :LD=>"Laccadives", :MH=>"Maharashtra", :ML=>"Meghalaya", :MN=>"Manipur", :MP=>"Madhya Pradesh", :MZ=>"Mizoram", :NL=>"Nagaland", :OR=>"Odisha", :PB=>"State of Punjab", :PY=>"Puducherry", :RJ=>"Rajasthan", :SK=>"Sikkim", :TG=>"Telangana", :TN=>"Tamil Nadu", :TR=>"Tripura", :UL=>"Uttarakhand", :UP=>"Uttar Pradesh", :WB=>"West Bengal"}
# states_list.keys.each do |state_code|
# 	state = State.find_or_create_by(name: states_list[state_code], active: true)
# 	cities_list = CS.cities(state_code , :in)
# 	Array.wrap(cities_list).compact.each do |city_name|
# 		City.find_or_create_by(state_id: state.id, name: city_name, active: true)
# 	end
# end

product_types = [
	{name: '1 BHK', active: true},
	{name: '2 BHK', active: true},
	{name: '3 BHK', active: true},
	{name: '4 BHK', active: true},
	{name: '5 BHK', active: true},
	{name: '6 BHK', active: true},
	{name: '7 BHK', active: true},
	{name: '8 BHK', active: true},
	{name: '9 BHK', active: true},
	{name: '9+ BHK', active: true}
]

product_types.each do |product_type|
	p_type = ProductType.find_or_initialize_by(name: product_type[:name])
	p_type.active = true
	p_type.save
end

product_operations = [
	{name: 'Buy', active: true},
	{name: 'Rent', active: true}
]

product_operations.each do |product_operation|
	p_operation = ProductOperation.find_or_initialize_by(name: product_operation[:name])
	p_operation.active = true
	p_operation.save
end

# Admin.find_or_create_by(email: 'admin@ghardekhoo.com', password: 'admin@123')