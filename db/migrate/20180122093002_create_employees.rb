class CreateEmployees < ActiveRecord::Migration[5.0]
  def change
    create_table :employees do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.integer :position, null: false, default: 0
      t.string :profile_picture
      t.boolean :published, default: false
      t.string :title
      
      t.timestamps
    end
  end
end
