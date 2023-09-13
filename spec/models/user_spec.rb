# frozen-string-literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject(:user) { build(:user) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:role) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'relations' do
    context "when the user's role is 'dealership'" do
      subject(:user) { build(:user, role: :dealership, dealership_id:) }

      context 'when the associated dealership_id is nil' do
        let(:dealership_id) { nil }

        it 'add an error to the base model' do
          user.validate

          expect(user.errors[:base]).to include('must be associated to a valid dealership')
        end

        it 'invalidates the user' do
          expect(user).not_to be_valid
        end
      end

      context 'when the associated dealership_id does not exist' do
        let(:dealership_id) { 0 }

        it 'add an error to the base model' do
          user.validate

          expect(user.errors[:base]).to include('must be associated to a valid dealership')
        end

        it 'invalidates the user' do
          expect(user).not_to be_valid
        end
      end

      context 'when a valid associated dealership_id is provided' do
        let(:dealership_id) { create(:dealership).id }

        it 'does not add an error to the base model' do
          user.validate

          expect(user.errors).to be_empty
        end

        it 'validates the user' do
          expect(user).to be_valid
        end
      end
    end
  end
end
