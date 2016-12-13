class AddPreviewToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :preview, :text, null: false, default: ''
    add_column :articles, :html_preview, :text, null: false, default: ''
    change_column :articles, :content, :text, null: false, default: ''
    change_column :articles, :html_content, :text, null: false, default: ''
  end
end