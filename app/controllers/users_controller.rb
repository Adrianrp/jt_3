class UsersController < ApplicationController

  #filter that calls the method: signed_in_user before any other method.
  # here we restrict the filter to act only on the :edit and :update 
  # actions by passing the appropriate :only options hash.
  before_action :signed_in_user, only: [:edit, :update, :show, :destroy]
  before_action :correct_role,   only: [:index]
  #before_action :correct_user,   only: [:edit, :update]

  def index
    # This together with the method will_paginate in view/index is in charge of
    # the pagination system.
    #@users = User.all
    @users = User.paginate(page: params[:page])
  end

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
      sign_in @user
  		flash[:success] = "Welcome to Jespers Torvekøkken dashboard"
  		# This redirects to the users show page
  		redirect_to @user
  	else
  		render 'new'
  end
end

 def edit
    # we dont need this here and neither in update anymore because now 
    # correct_user defines @user.
     @user = User.find(params[:id])
  end

# Uses update_attributes method to update the user based on the 
# submitted user_params hash.
  def update
     @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
      else
        render 'edit'
    end
  end

  def destroy
      User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
    end

private
    # Method signed_in? (Look in sessions_helper) returns a boolean, wether a 
    # user is signed in or not.
    def signed_in_user
      store_location # This method is in sessions helper and stores the requested URL in the session.
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # This tye of method is called strong parameters to help prevent this only accepts
    # permited data to the database, and strip everything that could be SQL injection. 
  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation, :role_id)
  	end

    def correct_role
      #@user = User.find(params[:id])
      redirect_to(root_url) unless current_user.role_id == 2
    end
end
