class EstimateRequestIndexSerializer < ActiveModel::Serializer
  attributes :id
  attributes :budget
  attributes :company
  attributes :deadline
  attributes :details
  attributes :document
  attributes :email
  attributes :is_admin_panel
  attributes :is_android
  attributes :is_backend_api
  attributes :is_design
  attributes :is_ios
  attributes :is_other
  attributes :name
  attributes :subject
end
