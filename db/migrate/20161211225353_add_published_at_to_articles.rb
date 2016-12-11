class AddPublishedAtToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :published_at, :date
  end
end