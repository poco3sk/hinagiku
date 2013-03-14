class User < ActiveRecord::Base
  attr_accessible :display_name, :login_name, :password, :password_confirmation

  has_secure_password

  before_create do
    self.auto_login_token = SecureRandom.hex
  end
end
