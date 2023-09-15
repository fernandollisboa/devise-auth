# frozen-string-literal: true

class UsersController < ApplicationController
  def index
    @users = User.all

    authorize @users
  end

  def new
    @user = User.new

    authorize @user
  end

  def create
    @user = User.new(user_params)

    authorize @user

    @user.save!
    redirect_to @user, status: :created
  end

  def show
    @user = User.find(params[:id])

    authorize @user
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :dealership_id)
  end
end
