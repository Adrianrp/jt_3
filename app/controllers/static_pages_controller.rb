class StaticPagesController < ApplicationController
  def home
  	# finds the number of records specified by limit ordered by primary key 
  	# in descending order
  	@products = Product.first(3)
  end

  def menus
  	@products = Product.where(category_id: 1)
  	# @season = Product.where(category_id: 3)
  end

  def buffets
  	@products = Product.where(category_id: 2)
  end
end
