class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new
    @order.order_items = (session[:cart] || {}).map do |variant_id, quantity|
      variant = ProductVariant.find(variant_id)
      order_item = OrderItem.new(product_variant: variant, quantity: quantity, price: variant.product.price)
      variant.stock -= quantity
      variant.save
      order_item
    end
    @order.total = @order.order_items.sum { |item| item.quantity * item.price }
    @order.status = "paid"
    @order.payment_method = params[:payment_method]
    if @order.save
      session[:cart] = {}
      redirect_to orders_path, notice: "Pedido criado com sucesso!"
    else
      redirect_to cart_path, alert: "Erro ao criar pedido. Tente novamente."
    end
  end
end
