class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  storage :file
  
  def store_dir
    "uploads/#{model.class.to_s.pluralize.underscore}/#{model.id}"
  end
  
  # Preview (should be 160px by 120px, scale to fill)
  version :thumb do
    process resize_to_fill: [160, 120]
  end
  
  # Image to insert into Articles
  version :regular do
    process resize_to_limit: [800, 800]
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