class RolesController < ApplicationController

  before_action :signed_in_user, only: [:index, :new, :create]
  
  def index
  	@role = Role.all
  end

  def new
  	@role = Role.new
  end

  def show
  	@role = Role.find(params[:id])
  end

   def create
  	@role = Role.new(role_params)
  	if @role.save
  		redirect_to @role
  	else
  		render 'new'
  	end
  end

  private
  # This protects the form from SQL injections
  def role_params
  	params.require(:role).permit(:role_name)  	
  end
end
