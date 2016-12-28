class AddPositionToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :position, :integer, default: 0
  end
end