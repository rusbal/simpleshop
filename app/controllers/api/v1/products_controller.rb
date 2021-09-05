class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_user
  before_action :set_product, only: [:show, :update, :destroy]

  def index
    @products = Product.all
  end

  def show; end

  def create
    product = Product.new(product_params)

    if product.save
      success
    else
      failure
    end
  end

  def update
    if @product.update(product_params)
      success
    else
      failure
    end
  end

  def destroy
    if @product.delete
      success
    else
      failure
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    failure
  end

  def product_params
    params.require(:product).permit(:region_id, :title, :description, :image_url, :price, :sku, :stock)
  end
end
