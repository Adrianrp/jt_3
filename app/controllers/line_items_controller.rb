class LineItemsController < ApplicationController
  # this incudes is inside the concerns folder, gives access to the current_cart method
  include CurrentCart
  # CALLBACKS
  # The set_cart() methos is to be added before the create() action
  before_action :set_cart, only: [:create]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    # Here we get the :product_id paramater from the request, we store it in a local
    # variable because there is no need to make it available to the view.
    product = Product.find(params[:product_id])
    # We pass the product we found into @cart.line_items.build. This causes a new line
    # item relationship to be built between the @cart object and the product
    # The relationship can be build from either end, and Rails will add the other one.
    # @line_item = @cart.line_items.build(product: product)

    # This uses the method add_product found in the model cart.rb
    # which makes the cart add quantites to a same product instead of putting it double
    @line_item = @cart.add_product(product.id)
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart }
        
        format.json { render action: 'show', status: :created, location: @line_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.update_attributes(line_item_params)
        if (@line_item.quantity == 0)
          @line_item.destroy
        end
        format.html { redirect_to @line_item.cart }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    respond_to do |format|
      if LineItem.find_by_cart_id(@line_item.cart_id).nil?
        format.html { redirect_to root_url, 
             notice: 'Your cart is currently empty' }
           else
            format.html { redirect_to :back }
      end
      #format.html {redirect_to :back}
      #format.html { redirect_to line_items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:product_id, :quantity)
    end
end
