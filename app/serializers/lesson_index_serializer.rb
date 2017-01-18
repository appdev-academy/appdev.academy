class LessonIndexSerializer < ActiveModel::Serializer
  attributes :id, :is_hidden, :position, :screencast_id, :slug, :title, :topic_id
  
  def topic_id
    object.screencast.topic_id
  end
end
