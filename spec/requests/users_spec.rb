# frozen-string-literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    context 'when the user is not authenticated' do
      it 'redirects to login page' do
        get '/users'

        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when the user is authenticated as admin' do
      let(:admin) { create(:user, :admin) }

      before do
        sign_in admin
      end

      context 'when two other users are registered' do
        let!(:users) { create_pair(:user) do

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
  end

  describe 'GET /users/:id' do
    context 'when the user is not authenticated' do
      it 'redirects to login page' do
        get('/users/1')

        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when the user is authenticated as admin' do
      let(:admin) { create(:user, :admin) }

      before do
        sign_in admin
      end

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
          get "/users/#{user.id}"

          expect(response).to have_http_status(:ok)
        end

        it 'renders information about the user', aggregate_failures: true do
          get "/users/#{user.id}"

          expect(response.body).to include(user.name)
          expect(response.body).to include(user.role)
        end
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

      it 'creates a new user' do
        expect { post('/users', params:) }.to change { User.count }.by(1)
      end
    end
  end

  describe 'PATCH /users/:id' do
    context 'when the user not authenticated' do
      it 'redirects to login page' do
        patch('/users')

        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when the user is authenticated as admin' do
      let(:admin) { create(:user, :admin) }
      let!(:user) { create(:user, :dealership) }

      before do
        sign_in admin
      end

      context 'when the attributes are invalid (empty attributes: name, email, current_password)' do
        let(:params) do
          {
            user: {
              id: user.id,
              name: '',
              role: ''
            }
          }
        end

        it 'returns status code 422' do
          patch("/users/#{user.id}", params:)

          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'returns the error messages for the invalid attributtes', aggregate_failures: true do
          patch("/users/#{user.id}", params:)

          expect(response.body).to match(/Name can('|&#39;)t be blank/)
          expect(response.body).to match(/Role can('|&#39;)t be blank/)
        end
      end

      context 'when the attributes are valid', aggregate_failures: true do
        let(:params) do
          {
            user: {
              name: 'John the Doe',
              role: 'admin'
            }
          }
        end

        it 'redirects to users page' do
          patch("/users/#{user.id}", params:)

          expect(response).to redirect_to users_path
        end

        it 'updates the user name' do
          expect {
            patch("/users/#{user.id}", params:)
          }.to change { user.reload.name }.from(user.name).to params[:user][:name]
        end

        it 'updates the user role' do
          expect {
            patch("/users/#{user.id}", params:)
          }.to change { user.reload.role }.from(user.role).to params[:user][:role]
        end
      end
    end
  end
end
