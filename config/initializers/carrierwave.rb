CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:               'AWS',
    aws_access_key_id:      ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key:  ENV['AWS_SECRET_ACCESS_KEY'],
    region:                 ENV['AWS_REGION']
  }
  
  config.fog_directory  = ENV['AWS_S3_BUCKET']
  config.fog_public     = true
  config.cache_dir      = Rails.root.join('tmp', 'uploads')
end

if Rails.env.test?
  # Make sure our uploader is auto-loaded
  ProfilePictureUploader
  
  # Use different dirs when testing
  CarrierWave::Uploader::Base.descendants.each do |klass|
    next if klass.anonymous?
    klass.class_eval do
      def cache_dir
        "#{Rails.root}/spec/support/uploads/tmp"
      end
      
      def store_dir
        "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end
    end
  end
end
