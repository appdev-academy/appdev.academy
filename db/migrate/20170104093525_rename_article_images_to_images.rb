class RenameArticleImagesToImages < ActiveRecord::Migration[5.0]
  def change
    rename_table :article_images, :images
  end
end