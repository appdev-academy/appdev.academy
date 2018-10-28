class AddMotivationToEmployees < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :motivation, :text
  end
end
