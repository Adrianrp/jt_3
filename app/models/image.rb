class Image < ActiveRecord::Base
	belongs_to :product

	validates :image, :product_id, presence: true
	validates :image, allow_blank: true, format: {
		with:  %r{\.(gif|jpg|png)\Z}i,
		message: 'must be a URL for GIF, JPG or PNG image'
	}
end
