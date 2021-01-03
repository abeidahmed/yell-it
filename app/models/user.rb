class User < ApplicationRecord
  before_validation :trim_white_spaces
  before_save :normalize_email_address
  before_create :generate_auth_token

  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates(
    :email_address,
    presence: true,
    uniqueness: { case_sensitive: false },
    length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
  )
  validates :full_name, length: { maximum: 255 }
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  private

  def trim_white_spaces
    self.email_address = email_address.to_s.strip
    self.full_name     = full_name.to_s.strip
  end

  def normalize_email_address
    self.email_address = email_address.downcase
  end

  def generate_auth_token
    generate_token(:auth_token)
  end

  def generate_token(column)
    loop do
      self[column] = SecureRandom.urlsafe_base64
      break unless User.exists?(column => self[column])
    end
  end
end
