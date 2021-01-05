FactoryBot.define do
  factory :project do
    name { "Project name" }
    sequence(:subdomain) { |n| "sub#{n}" }
    plan { "free" }
  end
end
