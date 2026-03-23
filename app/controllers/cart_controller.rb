class CartController < ApplicationController
  def show
    @cart = session[:cart] || {}
    @variants = ProductVariant.where(id: @cart.keys).index_by(&:id)
    @cart = @cart.select { |variant_id, _| @variants.key?(variant_id.to_i) }
  end

  def add
    session[:cart] ||= {}
    quantity = params[:quantity].to_i
    return redirect_to products_path, alert: "Quantidade deve ser maior que zero!" if quantity <= 0

    variant = ProductVariant.find_by(sku: params[:variant_id]) || ProductVariant.find_by(id: params[:variant_id])
    return redirect_to products_path, alert: "Variante não encontrada!" unless variant

    session[:cart][variant.id] ||= 0
    session[:cart][variant.id] += quantity
    if session[:cart][variant.id] > variant.stock
      session[:cart][variant.id] = variant.stock
      redirect_to cart_path, alert: "Quantidade máxima disponível atingida!"
      return
    end

    redirect_to cart_path, notice: "Produto adicionado ao Caixa"
  end

  def remove
    session[:cart] ||= {}
    variant = ProductVariant.find_by(sku: params[:variant_id]) || ProductVariant.find_by(id: params[:variant_id])
    return redirect_to cart_path, alert: "Variante não encontrada!" unless variant

    session[:cart][variant.id] ||= 0
    session[:cart][variant.id] -= 1

    session[:cart].delete(variant.id) if session[:cart][variant.id] <= 0

    redirect_to cart_path, notice: "Produto removido do Caixa!"
  end
end
