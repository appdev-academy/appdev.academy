class AddIpadMacosUrlsToProjects < ActiveRecord::Migration[5.2]
  def up
    add_column :projects, :app_store_ipad_url, :string
    add_column :projects, :app_store_macos_url, :string
  end
  
  def down
    remove_column :projects, :app_store_ipad_url
    remove_column :projects, :app_store_macos_url
  end
end
