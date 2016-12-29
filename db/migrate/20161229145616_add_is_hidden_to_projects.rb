class AddIsHiddenToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :is_hidden, :boolean, default: false
  end
end