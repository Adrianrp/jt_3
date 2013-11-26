class Product < ActiveRecord::Base
	has_many :images
	belongs_to :category

	validates :image_id, :title, :description, :price, :category_id,  presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validates :title, uniqueness: true
end
