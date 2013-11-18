class User < ActiveRecord::Base
	# This is a callback that forces lowercase on an email BEFORE SAVING it to the db
	before_save { self.email = email.downcase }
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /[\w+\-.]+@[a-z\d\-.]+\.[a-z]+/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	# This method is in charge also to confirm that the two passwords match before saving the password.
	has_secure_password
	#(Presence validations for the password and its confirmation are automatically added by has_secure_password.)
	validates :password, length: { minimum: 6 }
end
