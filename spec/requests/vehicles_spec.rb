# frozen_string_literal: true

require 'rails_helper'

describe 'Vehicle', type: :request do
  describe 'GET /vehicles' do
    it 'returns http status 200' do
      get '/vehicles'

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /vehicles' do
    let(:params) do
      {
        vehicle: {
          name: 'Lightning McQueen',
          brand: 'Rust-eze',
          model: 'SpeedCar',
          year: '2012',
          dealership: create(:dealership).id
        }
      }
    end

    context 'when the user is not authenticated' do
      it 'does not create a new vehicle' do
        expect {
          post('/vehicles', params:)
        }.not_to change { Vehicle.count }
      end

      it 'redirects to login page' do
        post('/vehicles', params:)

        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when the user is authenticated as admin' do
      let(:admin) { create(:user, :admin) }

      before do
        sign_in admin
      end

      it 'returns http status 201' do
        post('/vehicles', params:)
        expect(response).to have_http_status(:created)
      end

      it 'creates a new vehicle' do
        expect {
          post('/vehicles', params:)
        }.to change { Vehicle.count }.by(1)
      end
    end
  end

  describe 'PATCH /vehicles/:id' do
    let!(:vehicle) { create(:vehicle) }

    context 'when the user is not authenticated' do
      it 'redirects to login page' do
        patch("/vehicles/#{vehicle.id}")

        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when the user is authenticated as admin' do
      let(:admin) { create(:user, :admin) }
      let(:params) do
        {
          vehicle: {
            name: 'Lightning McQueen',
            brand: 'Rust-eze',
            model: 'SpeedCar',
            year: '2012',
            dealership: create(:dealership).id
          }
        }
      end

      before do
        sign_in admin
      end

      it 'redirects to vehicles page' do
        patch("/vehicles/#{vehicle.id}", params:)

        expect(response).to redirect_to vehicles_path
      end
    end
  end

  describe 'DELETE /vehicles/:id' do
    let!(:vehicle) { create(:vehicle) }

    context 'when the user is not authenticated' do
      it 'redirects to login page' do
        delete("/vehicles/#{vehicle.id}")

        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when the user is authenticated as admin' do
      let(:admin) { create(:user, :admin) }

      before do
        sign_in admin
      end

      it 'redirects to vehicles page' do
        delete("/vehicles/#{vehicle.id}")

        expect(response).to redirect_to vehicles_path
      end
    end
  end
end
