class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user! # Ensure user is authenticated
  before_action :set_user, only: [:show, :update, :deactivate, :upload_profile_picture, :update_roles]
  before_action :authorize_admin, only: [:index, :update_roles]
  before_action :authorize_user_or_admin, only: [:show, :update, :deactivate, :upload_profile_picture] # Admin or self can access

  # GET /api/v1/users (Admin only)
  def index
    users = User.all
    render json: users, status: :ok
  end

  # GET /api/v1/users/:id (Admin or User himself)
  def show
    render json: @user, status: :ok
  end

  # PUT /api/v1/users/:id (Admin or User himself)
  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /api/v1/users/:id/deactivate (Marks user as inactive instead of deleting)
  def deactivate
    if @user.deactivate!
      render json: { message: "User has been deactivated." }, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def upload_profile_picture
    if params[:profile_picture].present?
      @user.update(profile_picture: params[:profile_picture])
      render json: { message: "Profile picture uploaded successfully", url: @user.profile_picture.url }, status: :ok
    else
      render json: { error: "No image uploaded" }, status: :unprocessable_entity
    end
  end

  def update_roles
    if @user.update_roles(params[:roles])
      render json: { message: "Roles updated successfully", roles: @user.roles.pluck(:name) }
    else
      render json: { message: "Invalid role" }, status: :unprocessable_entity
    end
  end

  private

  # Find user by ID
  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: :not_found
  end

  # Allow only permitted parameters
  def user_params
    params.require(:user).permit(:first_name, :last_name, :date_of_birth, :gender, :email, :password, :password_confirmation)
  end

  # Ensure only admin can list users
  def authorize_admin
    unless current_user.has_role?(:admin)
      render json: { message: "Forbidden action" }, status: :unauthorized
    end
  end

  # Ensure only admin or the user himself can access/update/delete
  def authorize_user_or_admin
    render json: { error: "Unauthorized" }, status: :unauthorized unless current_user.has_role?(:admin) || current_user == @user
  end
end
