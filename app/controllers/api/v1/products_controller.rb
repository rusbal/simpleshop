class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_user
  before_action :set_product, only: %i[show update destroy]

  def index
    @products = authorized_scope(Product.all)
  end

  def show
    authorize! @product, to: :show?
  end

  def create
    product = Product.new(product_params.merge(region_id: params[:region_id]))
    authorize! product, to: :create?

    if product.save
      success
    else
      failure
    end
  end

  def update
    authorize! @product, to: :update?

    if @product.update(product_params)
      success
    else
      failure
    end
  end

  def destroy
    authorize! @product, to: :destroy?
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
    params.require(:product).permit(:product_id, :title, :description, :image_url, :price, :sku, :stock)
  end
end
