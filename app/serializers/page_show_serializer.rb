class PageShowSerializer < ActiveModel::Serializer
  attributes :content, :html_content, :id, :slug
end
