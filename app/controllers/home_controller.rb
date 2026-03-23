class HomeController < ApplicationController
  def index
  end

  def dashboard
    @orders_by_day = Order.group_by_day(:created_at).sum(:total)
    @avarege_order_value = Order.average(:total)
    @orders_today = Order.where(created_at: Time.zone.today.all_day).count
    @products_most_sold = OrderItem.joins(:product_variant => :product).group('products.name').sum(:quantity)
    @products_by_category = Product.joins(:product_variants).group(:name).count
    @payments_by_method = Order.group(:payment_method).sum(:total)
    @sales_by_product = OrderItem.joins(:product_variant => :product).group('products.name').sum('quantity * order_items.price')
  end
end
