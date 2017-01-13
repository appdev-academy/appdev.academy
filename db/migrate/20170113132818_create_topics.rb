class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.string :title, null: false, default: ''
      t.string :slug
      t.integer :position, null: false, default: 0
      t.timestamps
    end
  end
end
