class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :full_name, default: ""
      t.string :email_address, null: false, default: ""
      t.string :password_digest
      t.string :auth_token, null: false, default: ""

      t.timestamps
    end
    add_index :users, :auth_token
    add_index :users, :email_address, unique: true
  end
end
