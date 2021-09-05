class Api::V1::RegionsController < ApplicationController
  before_action :authenticate_user
  before_action :set_region, only: [:update, :destroy]

  def index
    @regions = Region.includes(:products)
  end

  def show
    @region = Region.where(id: params[:id]).includes(:products).first
    return failure if @region.nil?
  end

  def create
    region = Region.new(region_params)

    if region.save
      success
    else
      failure
    end
  end

  def update
    if @region.update(region_params)
      success
    else
      failure
    end
  end

  def destroy
    if @region.delete
      success
    else
      failure
    end
  end

  private

  def set_region
    @region = Region.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    failure
  end

  def region_params
    params.require(:region).permit(:title, :country, :currency, :tax)
  end
end
