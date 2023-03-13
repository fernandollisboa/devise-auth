class DealershipsController < ApplicationController
  def index
    @dealerships = Dealership.all
  end

  def new
    @dealership = Dealership.new
  end

  def create
    @dealership = Dealership.new(dealership_params)

    if @dealership.save
      redirect_to dealerships_url
    else
      render :edit
    end
  end

  def edit
    @dealership = Dealership.find(params[:id])
  end

  def update
    @dealership = Dealership.find(params[:id])

    if @dealership.update(dealership_params)
      redirect_to dealerships_url
    else
      render :edit
    end
  end

  def destroy
    @dealership = Dealership.find(params[:id])

    @dealership.destroy

    redirect_to dealerships_url
  end

  private

  def dealership_params
    params.require(:dealership).permit(:name)
  end
end
