class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  def store_dir
    "uploads/#{model.class.to_s.pluralize.underscore}/#{model.id}"
  end
  
  # Preview (should be 75px by 75px, scale to fill)
  version :thumb do
    process resize_to_fill: [75, 75]
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
