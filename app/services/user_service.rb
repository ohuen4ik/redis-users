# rubocop:disable Metrics/AbcSize
class UserService
  extend PasswordHandlerHelper
  extend ErrorsHandlerHelper

  class << self
    def sign_up(params)
      params = params.to_h.symbolize_keys
      validate_name_uniqueness(params[:username])
      validate_password_complexity(params[:password])
      storage.write(params[:username], { id: user_id,
                                         username: params[:username],
                                         password: safe_password(params[:password]) })
      success(user: response(params[:username]), message: 'User created', status_code: 201)
    rescue ValidationError => e
      failed(message: e.username_taken, status_code: 400)
    rescue PasswordValidation => e
      failed(message: e.weak_password, status_code: 400)
    end

    alias create_user sign_up

    def sign_in(params)
      params = params.to_h.symbolize_keys
      user   = storage.read(params[:username])&.symbolize_keys
      user_not_found(user)
      validate_password(user[:password], params[:password])
      success(user: response(params[:username]), status_code: 200)
    rescue NotFoundError => e
      e.user_not_found
      failed(message: e.user_not_found, status_code: 404)
    rescue ValidationError => e
      e.unauthorized
      failed(message: e.unauthorized, status_code: 401)
    end

    private

    def errors_msg(e,username,password)
      p [e,username,password]
      return [e.username_taken, e.weak_password] if username.present? & password.present?
      return e.username_taken if username.present?
      e.weak_password if password.present?
    end
    
    def user_id
      Digest::UUID.uuid_v4
    end

    def storage
      @storage ||= Rails.cache
    end

    def response(name)
      storage.read(name).except(:password)
    end
  end
end
# rubocop:enable Metrics/AbcSize
