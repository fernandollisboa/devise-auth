# frozen-string-literal: true

class CreateVehicle < ApplicationService
  def initialize(vehicle_params:, creator:)
    @vehicle = Vehicle.new(**vehicle_params)
    @creator = creator
  end

  def call
    vehicle.dealership = creator.dealership
    vehicle.save!

    { data: vehicle, success: true }
  end

  private

  attr_reader :vehicle, :creator
end
