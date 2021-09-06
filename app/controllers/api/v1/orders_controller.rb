class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_user
  before_action :set_order, only: [:show, :update, :destroy]

  def index
    @orders = authorized_scope(Order.includes(:order_items))
  end

  def show
    @order = Order.where(id: params[:id]).includes(:order_items).first
    authorize! @order, to: :show?
  end

  def create
    authorize! Order.new, to: :create?
    OrderCreator.run!(order_params)
    success
  rescue ActiveInteraction::InvalidInteractionError => errors
    failure(errors: [errors.to_s])
  end

  def update
    authorize! @order, to: :update?
    OrderCreator.run!(order_params.merge(order: @order))
    success
  rescue ActiveInteraction::InvalidInteractionError => errors
    failure(errors: [errors.to_s])
  end

  def destroy
    authorize! @order, to: :destroy?
    if @order.delete
      success
    else
      failure
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    failure
  end

  def order_params
    @order_params ||= {
      user_id: params[:order][:user_id].to_i,
      shipping_address: params[:order][:shipping_address],
      cart_items: param_cart_items
    }
  end

  def param_cart_items
    params[:order][:cart_items].map do |x|
      {
        price: x[:price].to_i,
        product_id: x[:product_id].to_i,
        quantity: x[:quantity].to_i
      }
    end
  end
end
