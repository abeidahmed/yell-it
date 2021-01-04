class Project < ApplicationRecord
  before_save :normalize_subdomain

  validates :name, presence: true, length: { maximum: 255 }
  validates :subdomain, length: { maximum: 63 }, uniqueness: { case_sensitive: false }

  private

  def normalize_subdomain
    self.subdomain = subdomain.to_s.downcase
  end
end
