class AddMeasuresToGalleryImages < ActiveRecord::Migration[5.0]
  def change
    add_column :gallery_images, :width, :float
    add_column :gallery_images, :height, :float
  end
end
