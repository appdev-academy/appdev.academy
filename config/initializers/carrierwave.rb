CarrierWave.configure do |config|
  config.storage = :file
  config.asset_host = ActionController::Base.asset_host
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
