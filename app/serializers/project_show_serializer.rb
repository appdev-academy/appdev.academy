class ProjectShowSerializer < ActiveModel::Serializer
  attributes :content, :html_content, :html_preview, :id, :preview, :position, :title
end