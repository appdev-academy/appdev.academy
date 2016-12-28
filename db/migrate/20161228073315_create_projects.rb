class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.text :description, null: false, default: ""
      t.text :html_description, null: false, default: ""
      t.timestamps
    end
  end
end