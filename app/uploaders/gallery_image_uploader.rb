class GalleryImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  # Storage
  storage :fog
  
  def store_dir
    "uploads/#{model.class.to_s.pluralize.underscore}/#{model.id}"
  end
  
  # Preview (should be fixed height 240px, resize to fill)
  version :thumb do
    process resize_to_fit: [240, 10000]
  end
  
  # White list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg png)
  end
  
  # Override the filename of the uploaded files.
  def filename
    "image.#{model.image.file.extension}" if original_filename
  end
end
