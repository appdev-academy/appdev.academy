class AddAppStoreAndGooglePlayUrlsToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :app_store_url, :string
    add_column :projects, :google_play_url, :string
  end
end
