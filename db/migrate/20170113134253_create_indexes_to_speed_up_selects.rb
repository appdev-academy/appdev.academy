class CreateIndexesToSpeedUpSelects < ActiveRecord::Migration[5.0]
  def change
    add_index :articles, :slug
    add_index :lessons, :slug
    add_index :pages, :slug
    add_index :projects, :slug
    add_index :screencasts, :slug
    add_index :topics, :slug
  end
end
