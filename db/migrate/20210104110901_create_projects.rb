class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects, id: :uuid do |t|
      t.string :name, null: false, default: ""
      t.string :subdomain, null: false, default: ""
      t.string :plan, null: false, default: "free"

      t.timestamps
    end
    add_index :projects, :plan
    add_index :projects, :subdomain, unique: true
  end
end
