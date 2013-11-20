class User < ActiveRecord::Base
	belongs_to :role

	# This is a callback that forces lowercase on an email BEFORE SAVING it to the db
	before_save { self.email = email.downcase }
	before_create :ensure_role_id_has_value
	before_create :create_remember_token

	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /[\w+\-.]+@[a-z\d\-.]+\.[a-z]+/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	# This method is in charge also to confirm that the two passwords match before saving the password.
	has_secure_password
	#(Presence validations for the password and its confirmation are automatically added by has_secure_password.)
	validates :password, length: { minimum: 6 }


	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		# We encrypt the token with SHA1 which is much faster than Bcrypt.
		# This is important for page loading since the algorithm is run in every
		# signed in page.
		Digest::SHA1.hexdigest(token.to_s)
	end

private
		def ensure_role_id_has_value
			if role_id.nil?
				self.role_id = 1
			end
		end

		def create_remember_token
			# By using self we ensure that a local variable is not made, in this case
			# self help to get the data from the user, not locally.
			self.remember_token = User.encrypt(User.new_remember_token)
		end
end
