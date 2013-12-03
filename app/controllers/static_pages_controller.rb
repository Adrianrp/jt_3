class StaticPagesController < ApplicationController
  def home
  	# finds the number of records specified by limit ordered by primary key 
  	# in descending order
  	 #@products = Product.limit(3).order(created_at: :desc)

    #@products = Product.all
    @products = Product.includes(:category)
                        .where("categories.extra = ?", 'false')
                        .limit(3)
                        .order(created_at: :desc)
  end

  def menus
  	@products = Product.where(category_id: 1)
  	# @season = Product.where(category_id: 3)
  end

  def buffets
  	@products = Product.where(category_id: 2)
  end
end
