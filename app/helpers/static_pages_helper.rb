module StaticPagesHelper

	# Receives a Image hash and returns the URL of that image
	def give_me_image(image)
		image.each do |image|
			return image.image
		end
	end
end