class LessonShowSerializer < ActiveModel::Serializer
  attributes :content, :html_content, :html_preview, :id, :image_url, :is_hidden, :preview, :short_description, :title
end
