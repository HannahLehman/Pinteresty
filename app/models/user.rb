class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_many :boards
	has_many :pins

	#validates :first_name, :last_name, :email, presence: true

	def full_name
		"#{first_name} #{last_name}"
	end
end
