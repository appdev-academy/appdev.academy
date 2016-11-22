class CreateArticleImages < ActiveRecord::Migration[5.0]
  def change
    create_table :article_images do |t|
      t.string :image, null: false
      t.timestamps
    end
  end
end