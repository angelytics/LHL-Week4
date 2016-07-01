class User < ActiveRecord::Base
has_many :musics
	validates :username, presence: true, uniqueness: true
validates :password, presence: true
validates :email, uniqueness: true

def self.check_crediential(username,password)
	if username.nil? or password.nil?
		 return false
	end
	
	unless User.exists?(username:username)
		return false
	end
	user = User.find_by(username:username)
	if password != user.password
		return false
	end
	return true

end
end