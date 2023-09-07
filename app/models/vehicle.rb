class Vehicle < ApplicationRecord
  belongs_to :dealership

  validates :brand, :name, :model, :year, :dealership, presence: true
end
