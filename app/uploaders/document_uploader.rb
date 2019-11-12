class DocumentUploader < CarrierWave::Uploader::Base
  storage :fog
  
  def initialize(*)
    super
    self.fog_directory = ENV['AWS_S3_PRIVATE_BUCKET']
  end
  
  def store_dir
    "uploads/#{model.class.to_s.underscore.pluralize}/#{model.id}/#{mounted_as}"
  end
end
