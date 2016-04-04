class Posts::Paragraphs::Comment < ActiveRecord::Base
  belongs_to :paragraph, class_name: '::Posts::Paragraph', foreign_key: 'posts_paragraph_id', primary_key: 'id'
  validates :posts_paragraph_id, presence: true
end
