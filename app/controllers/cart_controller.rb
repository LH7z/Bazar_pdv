class CartController < ApplicationController
  def show
    @cart = session[:cart] || {}
    @variants = ProductVariant.where(id: @cart.keys).index_by(&:id)
  end

  def add
    session[:cart] ||= {}
    quantity = params[:quantity].to_i
    return redirect_to products_path, alert: "Quantidade deve ser maior que zero!" if quantity <= 0

    session[:cart][params[:variant_id]] ||= 0
    session[:cart][params[:variant_id]] += quantity
    if session[:cart][params[:variant_id]] > ProductVariant.find(params[:variant_id]).stock
      session[:cart][params[:variant_id]] = ProductVariant.find(params[:variant_id]).stock
      redirect_to cart_path, alert: "Quantidade máxima disponível atingida!"
      return
    end

    redirect_to cart_path, notice: "Produto adicionado ao carrinho!"
  end

  def remove
    session[:cart] ||= {}
    session[:cart][params[:variant_id]] ||= 0
    session[:cart][params[:variant_id]] -= 1

    session[:cart].delete(params[:variant_id]) if session[:cart][params[:variant_id]] <= 0

    redirect_to cart_path, notice: "Produto removido do carrinho!"
  end
end
