class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable


    before_create :create_auth_token
    before_create :generate_username

    attr_accessor :profile_photo
    attr_accessor :user_registration

    validates :email, uniqueness: true, if: proc { email.present? }
    validates :facebook_user_id, uniqueness: true, if: proc { facebook_user_id.present? }
    validates :google_user_id, uniqueness: true, if: proc { google_user_id.present? }

    validates :first_name, presence: true
	validates :phone, presence: true, if: proc{ user_registration == true }
	validates_presence_of :password, if: proc{ :password_required? && user_registration == true}
	validates_confirmation_of :password, if: proc{ :password_required? && user_registration == true}

	after_initialize do
		user_registration = false
	end

    def name
    	"#{String(first_name)} " + "#{String(last_name)}"
    end

    def user_registration=(val)
	    @user_registration = ActiveModel::Type::Boolean.new.cast(val)
	end

	def user_registration
	    @user_registration
	end

    private
	    def create_auth_token
	    	self.token ||= Token.new.generate
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
end
