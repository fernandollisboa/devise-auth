# frozen_string_literal: true

class DealershipsController < ApplicationController
  def index
    @dealerships = Dealership.all

    authorize @dealerships
  end

  def new
    @dealership = Dealership.new

    authorize @dealership
  end

  def create
    @dealership = Dealership.new(dealership_params)

    authorize @dealership

    if @dealership.save
      redirect_to dealerships_url, status: :created
    else
      render :edit
    end
  end

  def edit
    @dealership = Dealership.find(params[:id])

    authorize @dealership
  end

  def update
    @dealership = Dealership.find(params[:id])

    authorize @dealership

    if @dealership.update(dealership_params)
      redirect_to dealerships_url
    else
      render :edit
    end
  end

  def destroy
    @dealership = Dealership.find(params[:id])

    authorize @dealership

    @dealership.destroy
    redirect_to dealerships_url
  end

  private

  def dealership_params
    params.require(:dealership).permit(:name)
  end
end
