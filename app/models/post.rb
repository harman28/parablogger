class Post < ActiveRecord::Base
	has_many :paragraphs, class_name: '::Posts::Paragraph', dependent: :destroy
	validates :title, presence: true

	def compact
		post = Post.select_nested_paragraphs.select_compact.find_by(id:self.id).as_json
		post.merge({ "comments" => comments.as_json })
	end

	def self.select_compact
		select(:id,:title)
	end

	private

	def self.select_nested_paragraphs
		joins(:paragraphs).group(:id)
		.select("json_agg(json_build_object('id', posts_paragraphs.id,
											'order_id', posts_paragraphs.order_id,
											'body', posts_paragraphs.body)) as paras")
	end

	def comments
		para_ids = Post.joins(:paragraphs).where(posts_paragraphs:{post_id:self.id}).pluck("posts_paragraphs.id")
		Posts::Paragraphs::Comment.select("id, body, posts_paragraph_id as para_id").where(posts_paragraph_id:para_ids)
	end
end
