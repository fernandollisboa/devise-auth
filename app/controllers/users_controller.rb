# frozen-string-literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    @user.save!
    redirect_to @user, status: :created
  rescue ActiveRecord::RecordInvalid
    render :new, status: :unprocessable_entity
  end

  def show
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'User Not Found'
    render status: :not_found
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :dealership_id)
  end
end
