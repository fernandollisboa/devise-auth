# frozen-string-literal: true

class CreateVehicle < ApplicationService
  def initialize(vehicle_params:, creator:)
    @vehicle = Vehicle.new(**vehicle_params)
    @creator = creator
  end

  def call
    vehicle.dealership = resolve_dealership
    vehicle.save!

    { data: vehicle, success: true }
  end

  private

  attr_reader :vehicle, :creator

  def resolve_dealership
    if creator.dealership?
      creator.dealership
    else
      Dealership.last
    end
  end
end
