class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword

  field :username, type: String
  field :password_digest, type: String

  # Secure password handling using bcrypt
  has_secure_password

  # Validations
  validates :username, presence: true, uniqueness: true

  # One-to-many relationship: a user can have many messages
  has_many :messages, dependent: :destroy
end
