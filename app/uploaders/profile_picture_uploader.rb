class ProfilePictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  def store_dir
    "uploads/#{model.class.to_s.pluralize.underscore}/#{model.id}"
  end
  
  # Square profile picture (should be 320px by 320px, scale to fill)
  version :rect_square do
    process resize_to_fill: [320, 320]
  end
  
  # Rectangular profile picture (should be 600px by 400px, scale to fill)
  version :rectangular do
    process resize_to_fill: [600, 400]
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
