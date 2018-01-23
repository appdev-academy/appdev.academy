class ChangeProfilePictureAndTitleFiledsForEmployees < ActiveRecord::Migration[5.0]
  def up
    change_column :employees, :profile_picture, :string, null: false
    change_column :employees, :title, :string, null: false
  end
  
  def down
    change_column :employees, :profile_picture, :string
    change_column :employees, :title, :string
  end
end
