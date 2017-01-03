class AddExtraFieldsToProject < ActiveRecord::Migration[5.0]
  def change
    rename_column :projects, :description, :content
    rename_column :projects, :html_description, :html_content
    add_column :projects, :preview, :text, null: false, default: ''
    add_column :projects, :html_preview, :text, null: false, default: ''
  end
end