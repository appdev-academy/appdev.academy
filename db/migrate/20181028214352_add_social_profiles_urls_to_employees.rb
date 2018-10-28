class AddSocialProfilesUrlsToEmployees < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :facebook_url, :string
    add_column :employees, :twitter_url, :string
    add_column :employees, :linkedin_url, :string
    add_column :employees, :github_url, :string
  end
end
