class Cart < ActiveRecord::Base
	has_many :line_items, dependent: :destroy

	def add_product(product_id)
		# find_by method returns either and existing line_item or nil
		# in difference of the where() method which returns an array of results
		current_item = line_items.find_by(product_id: product_id)
		if current_item
			current_item.quantity += 1
		else
			current_item = line_items.build(product_id: product_id)
		end
		current_item
	end

	def total_price
		line_items.to_a.sum { |item| item.total_price }
	end
end
