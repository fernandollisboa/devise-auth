# frozen_string_literal: true

require 'rails_helper'

describe 'Dealership', type: :request do
  describe 'GET /dealerships' do
    context 'when the user is not authenticated' do
      it 'redirects to login screen' do
        get '/dealerships'

        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when the user is authenticated as admin' do
      let(:admin) { create(:user, :admin) }

      before do
        sign_in admin
      end

      it 'returns http status 200' do
        get '/dealerships'

        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST /dealerships' do
    let(:params) do
      {
        dealership: {
          name: 'Samem Veículos'
        }
      }
    end

    context 'when the user is not authenticated' do
      it 'does not create a new dealership' do
        expect {
          post('/dealerships', params:)
        }.not_to change { Dealership.count }
      end

      it 'redirects to login page' do
        post('/dealerships', params:)

        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when the user is authenticated as admin' do
      let(:admin) { create(:user, :admin) }

      before do
        sign_in admin
      end

      it 'returns http status 201' do
        post('/dealerships', params:)

        expect(response).to have_http_status(:created)
      end

      it 'creates a new dealership' do
        expect {
          post('/dealerships', params:)
        }.to change { Dealership.count }.by(1)
      end
    end
  end

  describe 'PATCH /dealerships/:id' do
    let!(:dealership) { create(:dealership) }

    context 'when the user is not authenticated' do
      it 'redirects to login page' do
        patch("/dealerships/#{dealership.id}")

        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when the user is authenticated as admin' do
      let(:admin) { create(:user, :admin) }
      let(:params) do
        {
          dealership: {
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

      it 'redirects to dealerships page' do
        patch("/dealerships/#{dealership.id}", params:)

        expect(response).to redirect_to dealerships_path
      end
    end
  end

  describe 'DELETE /dealerships/:id' do
    let!(:dealership) { create(:dealership) }

    context 'when the user is not authenticated' do
      it 'redirects to login page' do
        delete("/dealerships/#{dealership.id}")

        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when the user is authenticated as admin' do
      let(:admin) { create(:user, :admin) }

      before do
        sign_in admin
      end

      it 'redirects to dealerships page' do
        delete("/dealerships/#{dealership.id}")

        expect(response).to redirect_to dealerships_path
      end
    end
  end
end
