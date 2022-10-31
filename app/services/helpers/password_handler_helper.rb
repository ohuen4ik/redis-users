module PasswordHandlerHelper

  def safe_password(password)
    BCrypt::Password.create(password)
  end

  def authenticated?(user_password, password)
    BCrypt::Password.new(user_password) == password
  end

  def decrypt_password(password)
    BCrypt::Password.new(BCrypt::Password.create(password))
  end
  
  def strong_password?(password)
    checker = StrongPassword::StrengthChecker.new
    checker.is_strong?(password.to_s)
  end
end
