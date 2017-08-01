class CreateGalleryImages < ActiveRecord::Migration[5.0]
  def change
    create_table :gallery_images do |t|
      t.string :image, null: false
      t.integer :position, default: 0, null: false
      t.integer :project_id, null: false
      t.index :project_id
      t.timestamps
    end
  end
end
