class AddIsHiddenToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :is_hidden, :boolean, default: false
  end
end