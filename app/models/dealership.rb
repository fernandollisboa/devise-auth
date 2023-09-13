# frozen_string_literal: true

class Dealership < ApplicationRecord
  has_many :vehicles

  validates :name, presence: true
end
