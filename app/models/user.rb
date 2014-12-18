class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]
	has_many :boards
	has_many :pins

	#validates :first_name, :last_name, :email, presence: true

	def full_name
		"#{first_name} #{last_name}"
	end

	def self.from_omniauth(auth)
		# where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
			where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			user.provider = auth.provider
			user.uid = auth.uid
			user.name = auth.info.name
			user.oauth_token = auth.credentials.token
			user.oauth_expires_at = Time.at(auth.credentials.expires_at)
			user.save!
		end
	end
end
