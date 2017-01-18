class ScreencastIndexSerializer < ActiveModel::Serializer
  attributes :id, :is_hidden, :position, :slug, :title, :topic_id
end
