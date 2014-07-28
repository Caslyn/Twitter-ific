class User < ActiveRecord::Base
	has_many :microposts, dependent: :destroy
	# Downcasing the email address before it is saved to the database
	before_save { email.downcase! }
	before_create :create_remember_token

	# Validating the presence of a name
	# Same as validates(:name, {presence: true ...})
	validates :name, presence: true, length: {maximum: 50}
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
					  uniqueness: { case_sensitive: false }

	has_secure_password
	validates :password, length: { minimum: 6 }

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def feed
		# This is preliminary.  See "Following users" for the full implementation
		Micropost.where("user_id = ?", id)
	end

	private

		def create_remember_token
			self.remember_token = User.digest(User.new_remember_token)
		end
end


