class AddPositionToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :position, :integer, default: 0
  end
end