class OrdersController < ApplicationController
  # So we get access to the current cart.
  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, only: [:index]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order_nr = Order.find(params[:id])
    @products = @order_nr.products
    @quantity = @order_nr.line_items
    @prod_quantity = give_quantity(@quantity)
    #@latest_order = @products_id.orders.order(:updated_at).last
  end

  # GET /orders/new
  def new
    if @cart.line_items.empty?
      redirect_to root_url, notice: "Your cart is empty"
      return
    end

    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    # This method comes from the Model.
    @order.add_line_items_from_cart(@cart)

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to @order }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirm
    @order = Order.find(params[:id])
    if @order.update_attribute(:confirmed, true)
      redirect_to root_url, notice: "Thank you for your order! You will be contacted within
                                     24hrs by one of our sales representatives"
      else
        render @order.show
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to admin_url }
      format.json { head :no_content }
    end
  end

  private

  # iterates through an array of line_items row an gives back the quantity of each product
  # bought
  def give_quantity(lineItem)
    lineItem.each do |item|
     return item.quantity
    end
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :address, :post_nr, :city, :tlf, :email, :pay_type)
    end
end
