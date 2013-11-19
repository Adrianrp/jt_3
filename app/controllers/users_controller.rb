class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def show
  	# Here params[:id] refers to the id that the controller gathers from the "GET" URL
  	# users/3
  	@user = User.find(params[:id])
  end

  # This uses POST to pass the :user object as a hash.
  def create
  	@user = User.new(user_params)
  	if @user.save
  		flash[:success] = "Welcome to Jespers Torvekøkken dashboard"
  		# This redirects to the users show page
  		redirect_to @user
  	else
  		render 'new'
  end
end

private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
end
