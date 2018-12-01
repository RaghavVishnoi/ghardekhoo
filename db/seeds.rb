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
	{name: 'construction'}, {name: 'carpentory'}, {name: 'electric'}, {name: 'paints'}, {name: 'plumbing'}, {name: 'security'}
]

employee_roles.each do |employee_role|
	Role.find_or_create_by(employee_role)
end

product_categories.each do |product_category|
	ProductCategory.find_or_create_by(product_category)
end