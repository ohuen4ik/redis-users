describe Api::V1::UsersController, type: :routing do
  describe 'POST #sign_in' do
    it 'should have routes enabled' do
      expect(post: '/api/v1/users/sign_in').to be_routable
      expect(post: '/api/v1/users/sign_in').to route_to(
        format: :json,
        controller: 'api/v1/users',
        action: 'sign_in'
      )
    end
  end

  describe 'POST #sign_up' do
    it 'should have routes enabled' do
      expect(post: '/api/v1/users/sign_up').to be_routable
      expect(post: '/api/v1/users/sign_up').to route_to(
        format: :json,
        controller: 'api/v1/users',
        action: 'sign_up'
      )
    end
  end
end
