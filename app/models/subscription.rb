class Subscription < ApplicationRecord
  belongs_to :project

  validates :project, presence: true, uniqueness: true
end
