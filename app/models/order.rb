class Order < ActiveRecord::Base
	has_many :line_items, dependent: :destroy
	has_many :products, through: :line_items

	PAYMENT_TYPES = [ "Credit card", "Money transfer" ]
	VALID_EMAIL_REGEX = /[\w+\-.]+@[a-z\d\-.]+\.[a-z]+/i

	validates :name, :address, :post_nr, :city, :tlf, presence: true
	validates :pay_type, inclusion: PAYMENT_TYPES
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

	# For each item that we transfer from the cart to the order we do two things,
	# 1. We set tje cart_id to nil so when the cart gets destroyed (in the order.create method)
	# the line item is not destroyed along with it.
	# 2. Add the item itself to the line_items collection for the order. Meaning adding the order_id
	# to the line_items table. This is done internally by rails without us having to set it
	# directly, because we declared a relation of has_many and belongs_to for orders and line_items
	def add_line_items_from_cart(cart)
		cart.line_items.each do |item|
			item.cart_id = nil
			line_items << item
		end
	end
end
