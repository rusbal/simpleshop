class Api::V1::UsersController < ApplicationController
  def index
    @users = authorized_scope(User.all)
  end

  def show
    @user = User.find(params[:id])
    authorize! @user, to: :show?
  end
end
