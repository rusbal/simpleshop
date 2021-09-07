class Api::V1::UsersController < ApplicationController
  def index
    @users = authorized_scope(User.all)
  end
end
