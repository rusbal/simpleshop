class ApplicationDeviseController < Devise::RegistrationsController
  include Knock::Authenticable

  def success(status = :ok)
    render_status('success', status)
  end

  def failure(status = :unprocessable_entity)
    render_status('failed', status)
  end

  private

  def render_status(readable_status, status)
    render json: { status: readable_status }, status: status
  end
end
