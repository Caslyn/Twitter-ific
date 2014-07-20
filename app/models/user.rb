class User < ActiveRecord::Base
	# Downcasing the email address before it is saved to the database
	before_save { self.email = email.downcase }

	# Validating the presence of a name
	# Same as validates(:name, {presence: true ...})
	validates :name, presence: true, length: {maximum: 50}
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
					  uniqueness: { case_sensitive: false }

	has_secure_password
	validates :password, length: { minimum: 6 }
end


