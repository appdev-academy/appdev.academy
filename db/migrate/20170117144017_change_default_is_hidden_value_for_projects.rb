class ChangeDefaultIsHiddenValueForProjects < ActiveRecord::Migration[5.0]
  def change
    change_column :projects, :is_hidden, :boolean, default: true
  end
end
