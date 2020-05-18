class Retailer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, authentication_keys: [:phone]

  # reverse_geocoded_by :lat, :lng

  attr_accessor :employee_code
  attr_accessor :category_ids
  attr_accessor :photos
  attr_accessor :profile_photo
  attr_accessor :distance

  has_many :retailer_product_categories, dependent: :destroy
  has_many :product_categories, through: :retailer_product_categories
  belongs_to :employee, optional: true
  has_many :retailer_products, dependent: :destroy
  has_many :retailer_photos, dependent: :destroy
  has_many :advertisements, dependent: :destroy
  has_many_attached :photos

  before_create :create_auth_token

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates_uniqueness_of :phone

  def name
    "#{String(first_name)} " + "#{String(last_name)}"
  end 

  def city_enum
    []
  end

  def state_enum
    State.pluck(:name)
  end

  def account_type_enum
    [['Free', 'free'],['Premium', 'premium']]
  end

  def account_status_enum
    [['Pending', 0],['Approved', 1],['Declined', 2]]
  end

  def sub_categories
    retailer_products.includes(:product_sub_category).map{|c| c.product_sub_category.p_name}.uniq
  end

private
  def create_auth_token
    self.token ||= Token.new.generate
  end
  
end
