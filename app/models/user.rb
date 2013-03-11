class User < ActiveRecord::Base
  attr_accessible :display_name, :login_name, :password_digest
end
