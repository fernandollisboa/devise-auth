# frozen-string-literal: true

require 'rails_helper'

RSpec.describe 'User', type: :request do
  describe 'GET /users' do
    context 'when no users are registered' do
      it 'returns http status 200' do
        get '/users'

        expect(response).to have_http_status(:ok)
      end

      it 'renders message informing that the user list is empty' do
        get '/users'

        expect(response.body).to include('No Users Yet Registered')
      end
    end

    context 'when two users are registered' do
      let!(:users) { create_pair(:user) }

      it 'returns http status 200' do
        get '/users'

        expect(response).to have_http_status(:ok)
      end

      it 'renders information about the users', aggregate_failures: true do
        get '/users'

        users.each do |user|
          expect(response.body).to include(user.name)
          expect(response.body).to include(user.email)
        end
      end
    end
  end

  describe 'GET /users/:id' do
    let(:user) { create(:user) }

    context 'when the user id does not exist' do
      let(:id) { 0 }

      it 'returns http status 404' do
        get "/users/#{id}"

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when the user id exists' do
      let!(:user) { create(:user) }

      it 'returns a http status 200' do
        get '/users'

        expect(response).to have_http_status(:ok)
      end

      it 'renders information about the user', aggregate_failures: true do
        get '/users'

        expect(response.body).to include(user.name)
        expect(response.body).to include(user.email)
        expect(response.body).to include(user.role)
      end
    end
  end

  describe 'POST /users' do
    context 'with invalid params (empty name, missing attributes: role, email, password, and password_confirmation)' do
      let(:params) { { user: { name: '' } } }

      it 'returns http status 422' do
        post('/users', params:)

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders the error messages', aggregate_failures: true do
        post('/users', params:)

        expect(response.body).to match(/Name can('|&#39;)t be blank/)
        expect(response.body).to match(/Email can('|&#39;)t be blank/)
        expect(response.body).to match(/Password can('|&#39;)t be blank/)
        expect(response.body).to match(/Role can('|&#39;)t be blank/)
      end

      it 'does not create a new user' do
        expect { post('/users', params:) }.not_to change { User.count }
      end
    end

    context "when passwords don't match" do
      let(:params) do
        {
          user: {
            password: 'password',
            password_confirmation: 'wordpass'
          }
        }
      end

      it 'returns http status 422' do
        post('/users', params:)

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders the error message' do
        post('/users', params:)

        expect(response.body).to match(/Password confirmation doesn('|&#39;)t match Password/)
      end

      it 'does not create a new user' do
        expect { post('/users', params:) }.not_to change { User.count }
      end
    end

    context 'with valid params' do
      let(:params) do
        {
          user: {
            name: 'Casemiro Miguel',
            email: 'caze@mail.com',
            role: 'admin',
            password: 'sekret_passphrase',
            password_confirmation: 'sekret_passphrase'
          }
        }
      end

      it 'returns http status 201' do
        post('/users', params:)

        expect(response).to have_http_status(:created)
      end

      it 'creates a new user' do
        expect { post('/users', params:) }.to change { User.count }.by(1)
      end
    end
  end
end
