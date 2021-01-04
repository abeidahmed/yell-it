class CreateMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :memberships, id: :uuid do |t|
      t.datetime :join_date, default: ""
      t.string :role, null: false, default: "editor"
      t.references :project, null: false, foreign_key: true, type: :uuid, index: { unique: true }
      t.references :user, null: false, foreign_key: true, type: :uuid, index: { unique: true }

      t.timestamps
    end
    add_index :memberships, %i[join_date role]
  end
end
