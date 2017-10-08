class AddSlugToTag < ActiveRecord::Migration[5.0]
  def up
    # Add slug column to Tags
    add_column :tags, :slug, :string
    
    # Generate slug for each existing Tag
    Tag.all.find_each do |tag|
      tag.save
    end
    
    # Add "not null" constraint to slug column for Tags
    change_column :tags, :slug, :string, null: false
  end
  
  def down
    add_column :tags, :slug
  end
end
