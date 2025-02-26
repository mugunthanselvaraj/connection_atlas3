# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionFix

  before_action :configure_permitted_parameters, if: :devise_controller?
  respond_to :json

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :date_of_birth, :gender])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :date_of_birth, :gender])
  end

  private

  def respond_with(resource, _opts = {})
    if request.method == "POST" && resource.persisted?
      render json: {
        message: "Signed up sucessfully.",
        data: resource,
      }, status: :ok
    elsif request.method == "DELETE"
      render json: {
        message: "Account deleted successfully.",
      }, status: :ok
    else
      render json: {
               message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}",
             }, status: :unprocessable_entity
    end
  end
end
