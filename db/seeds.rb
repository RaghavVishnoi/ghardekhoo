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
	{name: 'construction'}, {name: 'carpentry'}, {name: 'electric'}, {name: 'paints'}, {name: 'plumbing'}, {name: 'security'}, {name: 'real_estate'}, {name: 'property_dealer'}
]

employee_roles.each do |employee_role|
	Role.find_or_create_by(employee_role)
end

product_categories.each do |product_category|
	category = ProductCategory.find_or_create_by(product_category)
	case product_category[:name]
	when 'construction'
		category.product_sub_categories.find_or_create_by(name: 'Bricks')
		category.product_sub_categories.find_or_create_by(name: 'Cement')
		category.product_sub_categories.find_or_create_by(name: 'Concrete')
		category.product_sub_categories.find_or_create_by(name: 'Iron Rod')
		category.product_sub_categories.find_or_create_by(name: 'Concrete Mixer Machine')
		category.product_sub_categories.find_or_create_by(name: 'Tiles')
		category.product_sub_categories.find_or_create_by(name: 'Granite')
		category.product_sub_categories.find_or_create_by(name: 'Other')
	when 'carpentry'
		category.product_sub_categories.find_or_create_by(name: 'Wood')
		category.product_sub_categories.find_or_create_by(name: 'Glass')
		category.product_sub_categories.find_or_create_by(name: 'Steel')
		category.product_sub_categories.find_or_create_by(name: 'Other')
	when 'electric'
		category.product_sub_categories.find_or_create_by(name: 'Machines & Equipments')
	when 'paints'
		category.product_sub_categories.find_or_create_by(name: 'Berger Paints')
		category.product_sub_categories.find_or_create_by(name: 'Asian Paints')
		category.product_sub_categories.find_or_create_by(name: 'Other Paints')
	when 'plumbing'
		category.product_sub_categories.find_or_create_by(name: 'Equipments')
		category.product_sub_categories.find_or_create_by(name: 'Other')
	when 'security'
		category.product_sub_categories.find_or_create_by(name: 'Body Guard')
		category.product_sub_categories.find_or_create_by(name: 'House Keeping')
		category.product_sub_categories.find_or_create_by(name: 'Camera Installation')
		category.product_sub_categories.find_or_create_by(name: 'Other')
	when 'real_estate'
		category.product_sub_categories.find_or_create_by(name: 'Rent')
		category.product_sub_categories.find_or_create_by(name: 'Land')
		category.product_sub_categories.find_or_create_by(name: 'Plot')
		category.product_sub_categories.find_or_create_by(name: 'Flat')
		category.product_sub_categories.find_or_create_by(name: 'Other')
	when 'property_dealer'
		category.product_sub_categories.find_or_create_by(name: 'Other')
	end
end

ad_types = [
	{name: 'WebHomeListing'}, {name: 'WebFooterAds'}, {name: 'MobileBanner'}
]

ad_types.each do |ad_type|
	AdType.find_or_create_by(name: ad_type[:name])
end