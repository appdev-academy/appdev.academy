class Article < ApplicationRecord
  # Relationships
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  
  # Relationships validations
  validates :author, presence: true
  
  # Fields validations
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
  validates :html_content, presence: true
  validates :preview, presence: true
  validates :html_preview, presence: true
  
  # Set position to be the last in the list
  before_create :set_default_position
  
  private
    def set_default_position
      self.position = 1
      if Article.count > 0
        self.position = Article.maximum('position') + 1
      end
    end
end