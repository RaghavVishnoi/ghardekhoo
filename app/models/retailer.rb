class Retailer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, authentication_keys: [:phone]

  reverse_geocoded_by :lat, :lng

  attr_accessor :employee_code
  attr_accessor :category_ids
  attr_accessor :photos
  attr_accessor :profile_photo
  attr_accessor :distance

  has_many :product_categories, through: :retailer_product_categories
  has_many :retailer_product_categories, dependent: :destroy

  belongs_to :employee, optional: true
  has_many :retailer_products, dependent: :destroy
  has_many :retailer_photos, dependent: :destroy
  has_many :advertisements, dependent: :destroy

  before_create :create_auth_token

  validates_uniqueness_of :phone

  def name
    "#{String(first_name)}" + "#{String(last_name)}"
  end 

private
  def create_auth_token
    self.token ||= Token.new.generate
  end
  
end
