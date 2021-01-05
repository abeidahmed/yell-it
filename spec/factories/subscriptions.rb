FactoryBot.define do
  factory :subscription do
    project
    stripe_customer_id { "cus_13123123" }
    stripe_subscription_id { "sub_34234234" }
    card_last4 { "0144" }
    card_exp_month { 12 }
    card_exp_year { 2022 }
    card_brand { "Visa" }
  end
end
