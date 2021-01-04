class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects, id: :uuid do |t|
      t.string :name, null: false, default: ""
      t.string :subdomain, index: { unique: true }

      t.timestamps
    end
  end
end
