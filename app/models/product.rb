class Product < ActiveRecord::Base
	has_many :images
	belongs_to :category
	has_many :line_items

	before_destroy :ensure_not_referenced_by_any_line_item

	validates :image_id, :title, :description, :price, :category_id,  presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validates :title, uniqueness: true

	private

	# Ensure there are no line items referencing this product
	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			return true
		else
			errors.add(:base, 'Line Items present')
			return false
		end
	end
end
