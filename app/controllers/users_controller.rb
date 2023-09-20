# frozen-string-literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

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

  def edit
    @user = User.find(params[:id])

    authorize @user
  end

  def update
    @user = User.find(params[:id])

    authorize @user

    @user.update!(user_params)
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :role, :dealership_id)
  end
end
