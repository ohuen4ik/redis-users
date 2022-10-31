module ErrorsHandlerHelper
  def validate_name_uniqueness(name)
    raise ValidationError if storage.read(name).present?
  end

  def validate_password(user_password, password)
    raise ValidationError unless authenticated?(user_password, password)
  end

  def user_not_found(user)
    raise NotFoundError if user.nil?
  end

  def validate_password_complexity(password)
    raise PasswordValidation unless strong_password?(password)
  end

  class ValidationError < StandardError
    def username_taken
      'Username is taken'
    end

    def unauthorized
      'Wrong credentials'
    end
  end

  class NotFoundError < StandardError
    def user_not_found
      'User not found'
    end
  end

  class PasswordValidation < StandardError
    def weak_password
      'Weak password: Add complexity'
    end
  end

  def success(extra_fields = {})
    base_fields = {
      success?: true,
      errors: nil
    }
    build_struct(base_fields.reverse_merge(extra_fields))
  end

  def failed(extra_fields = {})
    base_fields = {
      success?: false,
      errors: nil
    }
    build_struct(base_fields.reverse_merge(extra_fields))
  end

  def build_struct(options)
    OpenStruct.new(options.merge(
                     fail?: !options[:success?]
                   ))
  end
end
