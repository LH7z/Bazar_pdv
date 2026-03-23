class ProductsController < ApplicationController
  def index
    if params[:query].present?
      @products = Product.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @products = Product.where(active: true)
    end
  end

  def show
    @product = Product.find(params[:id])
    @variants = @product.product_variants
  end

  def new
    @product = Product.new
    @product.product_variants.build
  end

  def create
    @product = Product.new(product_params)
    @product.active = true

    if @product.save
      redirect_to @product
    else
      @product.product_variants.build if @product.product_variants.empty?
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
    @product.product_variants.build if @product.product_variants.empty?
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :category, :active, :image,product_variants_attributes: [:id, :size, :color, :stock, :_destroy])
  end
end
