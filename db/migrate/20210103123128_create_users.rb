class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :full_name
      t.string :email_address, null: false, default: "", index: { unique: true }
      t.string :password_digest
      t.string :auth_token, null: false, default: ""

      t.timestamps
    end
    add_index :users, %i[auth_token email_address]
  end
end
