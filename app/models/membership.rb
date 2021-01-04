class Membership < ApplicationRecord
  belongs_to :project
  belongs_to :user

  enum role: { editor: "editor", owner: "owner" }

  # rubocop:disable Rails/UniqueValidationWithoutIndex
  validates(
    :user,
    uniqueness: { case_sensitive: false, scope: :project_id, message: "is already on the project team" },
  )
  # rubocop:enable Rails/UniqueValidationWithoutIndex
end
