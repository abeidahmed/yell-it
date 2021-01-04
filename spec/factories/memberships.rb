FactoryBot.define do
  factory :membership do
    project
    user
    join_date { "2020-11-23 09:33:17" }
    role { "editor" }

    trait :pending do
      join_date { "" }
    end

    trait :owner do
      role { "owner" }
    end

    trait :pending_owner do
      pending
      owner
    end
  end
end
