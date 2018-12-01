class Retailer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :product_categories, through: :retailer_product_categories
  has_many :retailer_product_categories, dependent: :destroy

  belongs_to :employee, optional: true
  has_many :retailer_products, dependent: :destroy
  
end
