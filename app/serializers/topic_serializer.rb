class TopicSerializer < ActiveModel::Serializer
  attributes :id, :is_hidden, :position, :slug, :title
end
