class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects, id: :uuid do |t|
      t.string :name, null: false, default: ""
      t.string :subdomain

      t.timestamps
    end
    add_index :projects, :subdomain
  end
end
