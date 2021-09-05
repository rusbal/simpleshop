class Api::V1::ConfirmationsController < ApplicationDeviseController
  def show
    user = User.find_by(confirmation_token: params[:confirmation_token])

    if user.confirm
      render plain: 'Your registration was successfully confirmed.',
             content_type: 'text/plain'
    else
      render plain: 'Attempt to confirm your registration failed.',
             content_type: 'text/plain',
             status: :unprocessable_entity
    end
  end
end
