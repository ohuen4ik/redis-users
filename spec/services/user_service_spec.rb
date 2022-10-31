require 'spec_helper'

RSpec.describe UserService, type: :service do
  before(:all) do
    Rails.cache.clear
  end

  let(:params) { { username: 'test_username', password: 'password123$' } }
  let(:new_params) { { username: 'unknown', password: 'password123$' } }
  let(:wrong_pass_params) { { username: 'test_username', password: 'wrong' } }

  describe 'sign up' do
    it 'positive scenario sign up successfully' do
      resp = described_class.sign_up(params)
      expect(resp.message).to eq('User created')
      expect(resp.user[:username]).to eq(params[:username])
      expect(resp.status_code).to eq(201)
    end

    it 'negative scenario username is taken' do
      resp = described_class.sign_up(params)
      expect(resp.message).to eq('Username is taken')
      expect(resp.status_code).to eq(400)
    end
  end

  describe 'sign in' do
    it 'positive scenario sign in successfully' do
      resp = described_class.sign_in(params)
      expect(resp.user[:username]).to eq(params[:username])
      expect(resp.status_code).to eq(200)
    end

    it 'negative scenario user not found' do
      resp = described_class.sign_in(new_params)
      expect(resp.message).to eq('User not found')
      expect(resp.status_code).to eq(404)
    end

    it 'negative scenario wrong pass' do
      resp = described_class.sign_in(wrong_pass_params)
      expect(resp.message).to eq('Wrong credentials')
      expect(resp.status_code).to eq(401)
    end
  end
end
