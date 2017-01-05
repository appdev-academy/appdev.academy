class AddSlugToProject < ActiveRecord::Migration[5.0]
  def up
    add_column :projects, :slug, :string
    # Generate slugs for previously created Projects
    Project.all.each do |project|
      project.save
    end
  end
  
  def down
    remove_column :projects, :slug
  end
end