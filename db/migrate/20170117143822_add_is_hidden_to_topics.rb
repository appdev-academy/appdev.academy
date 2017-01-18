class AddIsHiddenToTopics < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :is_hidden, :boolean, default: true
  end
end
