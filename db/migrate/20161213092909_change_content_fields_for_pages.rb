class ChangeContentFieldsForPages < ActiveRecord::Migration[5.0]
  def change
    change_column :pages, :content, :text, null: false, default: ''
    change_column :pages, :html_content, :text, null: false, default: ''
  end
end