# frozen_string_literal: true

class VehiclesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @vehicles = Vehicle.all
  end

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)

    @vehicle.dealership = resolve_dealership
    if @vehicle.save
      redirect_to vehicles_url, status: :created
    else
      render :new
    end
  end

  def edit
    @vehicle = Vehicle.find(params[:id])
  end

  def update
    @vehicle = Vehicle.find(params[:id])

    if @vehicle.update(vehicle_params)
      redirect_to vehicles_url
    else
      render :edit
    end
  end

  def destroy
    @vehicle = Vehicle.find(params[:id])

    @vehicle.destroy

    redirect_to vehicles_url
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:brand, :name, :model, :year, :comments)
  end

  def resolve_dealership
    if current_user.dealership?
      current_user.dealership
    else
      Dealership.last
    end
  end
end
