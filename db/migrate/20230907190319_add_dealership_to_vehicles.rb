class AddDealershipToVehicles < ActiveRecord::Migration[7.0]
  def change
    add_reference :vehicles, :dealership, null: false, foreign_key: true, index: true
  end
end
