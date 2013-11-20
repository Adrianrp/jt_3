class StaticPagesController < ApplicationController
  def home
  end

  def menus
  	@products = Product.where(category_id: 1)
  end

  def buffets
  end
end
