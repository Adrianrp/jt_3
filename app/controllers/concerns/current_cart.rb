module CurrentCart
	# This module lets us share code between controllers
	extend ActiveSupport::Concern

	private

	# This method starts by getting the :cart_id from the session object
	# and then attempts to find a cart corresponding to this ID. If such a cart
	# record is not found then create a new Cart.
	def set_cart
		@cart = Cart.find(session[:cart_id])
	rescue ActiveRecord::RecordNotFound
		@cart = Cart.create
		session[:cart_id] = @cart.id
	end
end
