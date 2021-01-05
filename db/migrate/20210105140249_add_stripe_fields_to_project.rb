class AddStripeFieldsToProject < ActiveRecord::Migration[6.1]
  def change
    change_table :projects, bulk: true do |t|
      t.string :stripe_customer_id, default: ""
      t.string :stripe_subscription_id, default: ""
      t.string :card_brand, default: ""
      t.integer :card_exp_month, default: ""
      t.integer :card_exp_year, default: ""
      t.string :card_last4, default: ""
    end
    add_index :projects, %i[stripe_customer_id stripe_subscription_id]
  end
end
