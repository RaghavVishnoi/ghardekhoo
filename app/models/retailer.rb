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

  belongs_to :employee, optional: true
  has_many :retailer_products, dependent: :destroy
  has_many :retailer_photos, dependent: :destroy
  has_many :advertisements, dependent: :destroy
  has_many_attached :photos
  has_many :retailer_reviews

  accepts_nested_attributes_for :retailer_products

  before_create :create_auth_token
  before_save :unformat_phone
  after_save :update_retailer_product
  before_create :generate_username

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates_uniqueness_of :phone

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

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

  def categories
    product_categories.pluck(:name).join(',')
  end

  def sub_categories
    sub_category_ids = retailer_products.pluck(:sub_category_id)
    ProductSubCategory.where(id: sub_category_ids).pluck(:name)
  end

  def generate_username
    username = String(first_name) + String(last_name)
    tempUserName = castUserName(username)
    userNameSplit = tempUserName.split(/(\d+)/)
    if userNameSplit[1].present?
      tempUserName = userNameSplit[0] + userNameSplit[1]
    else
      tempUserName = userNameSplit[0]
    end
    tempUserName.delete(' ').downcase
    self.username ||= tempUserName
  end

  def castUserName(username)
    tempUserName = username
    count = 1
    while User.exists?(username: tempUserName.downcase)
      tempUserName = nil
      count += 1
      tempUserName = username + String(count)
    end
    tempUserName
  end

  def unformat_phone
    if self.phone.present?
      begin
        self.phone = self.phone.delete('-').delete('(').delete(')').delete(' ')
      rescue StandardError
        self.phone
      end
    end
  end

  def account_status_enum
    [['Pending', 0],['Approved', 1],['Declined', 2]]
  end

  def sub_categories
    retailer_products.includes(:product_sub_category).map{|c| c.product_sub_category.p_name}.uniq
  end

  def active_products
    retailer_products.where(status: 1, active: true)
  end

private
  def create_auth_token
    self.token ||= Token.new.generate
    self.access_token ||= Token.new.generate
  end

  def update_retailer_product
    # retailer_products.update_all(state: self.state, city: self.city) if retailer_products.present?
  end
  
end
