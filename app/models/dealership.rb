# frozen_string_literal: true

class Dealership < ApplicationRecord
  has_many :vehicles, dependent: :destroy
  has_many :users, dependent: :destroy

  validates :name, presence: true
end
