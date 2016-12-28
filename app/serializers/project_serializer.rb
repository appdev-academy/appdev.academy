class ProjectSerializer < ActiveModel::Serializer
  attributes :description, :html_description, :id, :position, :title
end