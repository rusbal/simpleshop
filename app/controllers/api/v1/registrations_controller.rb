class Api::V1::RegistrationsController < ApplicationDeviseController
  def create
    user = User.new(registration_params)

    if user.save
      success
    else
      failure
    end
  end

  private

  def registration_params
    params.require(:registration).permit(:name, :email, :password)
  end
end
