class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  def store_dir
    "uploads/#{model.class.to_s.pluralize.underscore}/#{model.id}"
  end
  
  # Preview (should be 140px by 140px, scale to fill)
  version :thumb do
    process resize_to_fill: [140, 140]
  end
  
  # Rectangular avatar for employees (should be 300px by 200px, scale to fill)
  version :rectangular do
    process resize_to_fill: [300, 200]
  end

  # White list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg png)
  end
  
  # Override the filename of the uploaded files.
  def filename
    "image.#{model.profile_picture.file.extension}" if original_filename
  end
end
