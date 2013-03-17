class User < ActiveRecord::Base
  has_many :tasks, foreign_key: :owner_id, dependent: :destroy
  has_many :categories, foreign_key: :owner_id, dependent: :destroy

  attr_accessible :display_name, :login_name, :password, :password_confirmation

  has_secure_password

  before_create do
    self.auto_login_token = SecureRandom.hex
  end
end
