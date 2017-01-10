class AddShortDescriptionToArticle < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :short_description, :string, null: false, default: ''
  end
end