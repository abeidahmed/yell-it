class AddStripeFieldsToProject < ActiveRecord::Migration[6.1]
  def change
    change_table :projects, bulk: true do |t|
      t.string :stripe_customer_id
      t.string :stripe_subscription_id
      t.string :card_brand
      t.integer :card_exp_month
      t.integer :card_exp_year
      t.string :card_last4
    end
    add_index :projects, %i[stripe_customer_id stripe_subscription_id]
  end
end
