# frozen-string-literal: true

class User < ApplicationRecord
  validates :name, presence: true
  validates :role, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true, confirmation: true
  enum :role, admin: 'admin', dealership: 'dealership'
  validate :dealership_presence, if: :dealership?

  belongs_to :dealership, optional: true

  devise :database_authenticatable, :registerable, :validatable

  def admin?
    role == 'admin'
  end

  def dealership?
    role == 'dealership'
  end

  private

  def dealership_presence
    if dealership.blank?
      errors.add(:base, 'must be associated to a valid dealership')
    end
  end
end
