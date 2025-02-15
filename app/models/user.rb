# frozen-string-literal: true

class User < ApplicationRecord
  validates :name, presence: true
  validates :role, presence: true
  validates :email, uniqueness: true
  enum :role, admin: 'admin', dealership: 'dealership'
  validate :dealership_presence, if: :dealership?

  belongs_to :dealership, optional: true

  devise :database_authenticatable, :registerable, :validatable

  private

  def dealership_presence
    if dealership.blank?
      errors.add(:base, 'must be associated to a valid dealership')
    end
  end
end
