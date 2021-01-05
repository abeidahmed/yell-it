class Project < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  before_save :normalize_subdomain

  enum plan: { free: "free", premium: "premium" }

  validates :name, presence: true, length: { maximum: 255 }
  validates :subdomain, presence: true, length: { maximum: 63 }, uniqueness: { case_sensitive: false }

  private

  def normalize_subdomain
    self.subdomain = subdomain.downcase
  end
end
