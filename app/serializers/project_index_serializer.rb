class ProjectIndexSerializer < ActiveModel::Serializer
  attributes :html_preview, :id, :is_hidden, :position, :slug, :title
end
