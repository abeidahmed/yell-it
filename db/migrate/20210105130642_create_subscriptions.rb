class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions, id: :uuid do |t|
      t.string :stripe_customer_id, default: ""
      t.string :stripe_subscription_id, default: ""
      t.string :card_last4, default: ""
      t.integer :card_exp_month, default: ""
      t.integer :card_exp_year, default: ""
      t.string :card_brand, default: ""
      t.references :project, null: false, foreign_key: true, type: :uuid, index: { unique: true }

      t.timestamps
    end
  end
end
