# frozen-string-literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :role, :dealership_id)
  end
end
