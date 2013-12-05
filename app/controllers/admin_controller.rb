class AdminController < ApplicationController
	before_action :signed_in_user, only: [:index]
	
  def index
  	@total_orders = Order.count
  	@orders = Order.all
  end
end
