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

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
  validates :password, presence: true
  validates_confirmation_of :password

  before_create :create_auth_token
  before_save :unformat_phone
  before_create :generate_username

  validates_uniqueness_of :phone

  def name
    "#{String(first_name)} " + "#{String(last_name)}"
  end 

  def account_type_enum
    [['Free', 'free'],['Premium', 'premium']]
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
    retailer_products.includes(:product_sub_category).map{|c| c.product_sub_category.name}.uniq
  end

private
  def create_auth_token
    self.token ||= Token.new.generate
  end
  
end
