product_category = product.try(:product_sub_category)
json.id product.id
json.sku_code product.sku_code
json.product_name product.product_name
json.price product.price
json.category product_category.try(:product_category).try(:name)
json.product_category product_category.try(:name)
json.active product.active