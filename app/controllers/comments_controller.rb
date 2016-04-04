class CommentsController < ApplicationController
	include ApplicationHelper

	skip_before_action :verify_authenticity_token

	def new
		para = Posts::Paragraph.find_by(id:params[:paragraph_id])
		if para.present?
			body = params[:body]
			comment = Posts::Paragraphs::Comment.new(body:body,posts_paragraph_id:para.id)
			if comment.save
				result = comment.paragraph.post.compact
				status = 200
			else
				result = { message: "Error. Invalid comment." }
				status = 400
			end
		else
			result = { message: "Error. Invalid paragraph." }
			status = 400
		end
		process_response(result, status, params)
	end
end
