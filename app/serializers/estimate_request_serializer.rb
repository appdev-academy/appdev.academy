class EstimateRequestSerializer < ActiveModel::Serializer
  attributes :budget
  attributes :company
  
  attributes :created_at
  def created_at
    object.created_at.strftime('%B %d, %Y')
  end
  
  attributes :deadline
  def deadline
    object.deadline&.strftime('%B %d, %Y')
  end
  
  attributes :details
  
  attributes :document
  def document
    object.document.url
  end
  
  attributes :email
  attributes :id
  attributes :is_admin_panel
  attributes :is_android
  attributes :is_backend_api
  attributes :is_design
  attributes :is_ios
  attributes :is_other
  attributes :name
  attributes :subject
end
