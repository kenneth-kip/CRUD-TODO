class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
          # :confirmable
  include DeviseTokenAuth::Concerns::User
  # has_secure_password

  # # Model associations
  has_many :bucketlists, foreign_key: :created_by
  # # Validations
  # validates_presence_of :username, :email, :password_digest
end
