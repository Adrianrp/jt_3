module SessionsHelper

	def sign_in(user)
		# create a new token
		remember_token = User.new_remember_token
		# place the unencrypted token in the browser cookies. permanent is a method that derives from
		# another method: 20.years.from_now.
		cookies.permanent[:remember_token] = remember_token
		# save the encrypted token to the database
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		# set the current user equal to the given user. This is an assignment, we must
		# define this assignemnt function. (by defining the def current_user=)
		# without self, Ruby would simply create a local variable called current_user.
		# We need to make the current user available to views and controllers.
		self.current_user = user
	end

	def signed_in?
    	!current_user.nil?
  	end

  	def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  

	def current_user=(user)
   	    @current_user = user
  end

  	def current_user
  		# To find the session user we need first to encrypt the token so we can find
  		# the encryped remember_token in the database.
   		remember_token = User.encrypt(cookies[:remember_token])
   		# the construction calls the find_by method the first time current_user is called, 
   		# but on subsequent invocations returns @current_user without hitting the database.
   		# ||= (means: or equals)
    	@current_user ||= User.find_by(remember_token: remember_token)
  end
    # Returns a boolean
    def current_user?(user)
    user == current_user
  end

  # This method redirects to the requested URL if it exists, or some default
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default) # if it results nil redirect to default
    session.delete(:return_to)
  end
  # This method puts the requested URL in the session variable under the key :return_to,
  # only for a GET request (if request.get?)
  # To be able to use store_location we add it to the signed_in_user before filter.
  def store_location
    session[:return_to] = request.url if request.get?
  end
end

# After the cookie is set, on subsequent page views we can retrieve the user 
# with code like: User.find_by(remember_token: remember_token)
 