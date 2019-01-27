class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable


    before_create :create_auth_token
    before_create :generate_username

    attr_accessor :profile_photo

    validates :email, uniqueness: true, if: proc { email.present? }
    validates :facebook_user_id, uniqueness: true, if: proc { facebook_user_id.present? }
    validates :google_user_id, uniqueness: true, if: proc { google_user_id.present? }

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
