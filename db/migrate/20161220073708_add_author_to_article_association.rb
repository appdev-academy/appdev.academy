class AddAuthorToArticleAssociation < ActiveRecord::Migration[5.0]
  def change
    # Create column
    add_column :articles, :author_id, :integer
    # Create relationships for all previous Articles
    first_author = User.first
    Article.all.each do |article|
      article.author_id = first_author.id
      article.save
    end
    # Change column, make it arbitrary
    change_column :articles, :author_id, :integer, null: false
    add_index :articles, :author_id
  end
end