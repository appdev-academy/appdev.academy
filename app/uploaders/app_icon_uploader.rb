class AppIconUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  # Storage
  storage :fog
  
  def store_dir
    "uploads/#{model.class.to_s.pluralize.underscore}/#{model.id}"
  end
  
  # Image used across the website (should be 150px by 150px, scale to fill)
  version :regular do
    process resize_to_fill: [150, 150]
  end
  
  # White list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg png)
  end
  
  # Override the filename of the uploaded files.
  def filename
    "image.#{model.app_icon.file.extension}" if original_filename
  end
end
