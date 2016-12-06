class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.string :slug, null: false
      t.text :content, null: false
      t.text :html_content, null: false
      t.timestamps
    end
  end
end