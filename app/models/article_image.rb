class ArticleImage < ApplicationRecord
  mount_uploader :image, ArticleImageUploader
end