class AddSlugToArticles < ActiveRecord::Migration[5.0]
  def up
    add_column :articles, :slug, :string
    # Generate slugs for previously created Articles
    Article.all.each do |article|
      article.save
    end
  end
  
  def down
    remove_column :articles, :slug
  end
end