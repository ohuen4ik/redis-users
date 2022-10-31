require 'swagger_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  include PasswordHandlerHelper

  before(:all) do
    Rails.cache.clear
    UserService.create_user(username: 'user', password: 'password123$')
  end

  path '/api/v1/users/sign_in' do
    post 'User sign_in' do
      tags 'Sign In'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          password: { type: :string },
          username: { type: :string }
        },
        required: %w[username password]
      }

      response '200', 'Sign in successfully' do
        let(:user) { { username: 'user', password: 'password123$' } }
        run_test!
      end

      response '404', 'Use Not found' do
        let(:user) { { password: 'random user', username: 'new password123$' } }
        run_test!
      end

      response '401', 'Wrong credentials' do
        let(:user) { { password: 'xxx', username: 'user' } }
        run_test!
      end
    end
  end

  path '/api/v1/users/sign_up' do
    post 'User sign_up' do
      tags 'Sign Up'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          password: { type: :string }
        },
        required: %w[username password]
      }

      response '201', 'user created' do
        let(:user) { { password: 'secret pass', username: 'cool username' } }
        run_test!
      end

      response '400', 'invalid params in request' do
        let(:user) { { random_param: 'xxxx', username: 'cool username' } }
        run_test!
      end
    end
  end
end
