class CreateScreencasts < ActiveRecord::Migration[5.0]
  def change
    create_table :screencasts do |t|
      t.string :title, null: false, default: ''
      t.string :slug
      t.string :short_description, null: false, default: ''
      t.string :image_url
      t.text :preview, null: false, default: ''
      t.text :html_preview, null: false, default: ''
      t.text :content, null: false, default: ''
      t.text :html_content, null: false, default: ''
      t.boolean :is_hidden, default: true
      t.integer :topic_id, null: false
      t.integer :position, null: false, default: 0
      t.timestamps
    end
  end
end
