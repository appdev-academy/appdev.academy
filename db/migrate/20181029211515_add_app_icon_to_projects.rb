class AddAppIconToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :app_icon, :string
  end
end
