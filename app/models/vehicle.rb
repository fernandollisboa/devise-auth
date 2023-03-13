class Vehicle < ApplicationRecord
  validates :brand, :name, :model, :year, presence: true
end
