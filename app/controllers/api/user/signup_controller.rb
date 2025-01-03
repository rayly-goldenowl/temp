class Api::User::SignupController < Devise::RegistrationsController
  respond_to :json
  skip_before_action :verify_authenticity_token

  private
  def respond_with(resource, _opts = {})
    if request.method == "DELETE"
      render status: :ok
    elsif request.method == "POST" && resource.persisted?
      render json: {
        user: resource
      }, status: :ok
    else
      render json: {
        messages: resource.errors.full_messages
      }, status: :unprocessable_entity
    end
  end
end

