class Posts::Paragraph < ActiveRecord::Base
  belongs_to :post, touch: true
  has_many :comments, class_name: '::Posts::Paragraphs::Comment', foreign_key: 'posts_paragraph_id', dependent: :destroy
end
