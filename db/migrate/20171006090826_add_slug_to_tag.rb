class AddSlugToTag < ActiveRecord::Migration[5.0]
  def up
    add_column :tags, :slug, :string, null: false
  end
  
  def down
    add_column :tags, :slug
  end
end
