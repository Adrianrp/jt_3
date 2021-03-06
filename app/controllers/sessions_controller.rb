class SessionsController < ApplicationController

	def new	
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			# this method is sessions h.
			sign_in user
			# This method is in sessions helper
			redirect_back_or user
		else
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		sign_out
		flash[:success] = "You have been signed out"
		redirect_to root_url
	end
end
