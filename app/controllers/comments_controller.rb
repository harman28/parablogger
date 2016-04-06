class CommentsController < ApplicationController
	include ApplicationHelper

	skip_before_action :verify_authenticity_token

=begin
  :method: new
  <b>Common Name</b> Post a new Comment<br>
  <b>Short Description</b> Creates a new Comment<br>
  <b>Endpoints</b> Web<br>
  <b>Request Type</b> POST<br>
  <b>Route </b> /comments/<br>
  <b>Authentication Required</b> Public<br>
  <b>Request Format</b>
    {
	  "paragraph_id": 2
	  "body": "That makes no sense at all"
	}
  <b>Response Format</b> A json array containing list of society objects<br>
    {
		"status": "OK",
		"message": "success",
		"result": {
			"id": 1,
			"title": "First Post Ever",
			"paras": [{
				"id": 1,
				"order_id": 0
				"body": "This is the first post ever."
			}, {
				"id": 2,
				"order_id": 1
				"body": "It's a great post because it has multiple paragraphs."
			}, {
				"id": 3,
				"order_id": 2
				"body": "Most of them are separated by 2 newlines.\nBut some are not."
			}, {
				"id": 4,
				"order_id": 3
				"body": "Some are separated by more."
			}, {
				"id": 5,
				"order_id": 4
				"body": "Enough of this.\n"
			}],
			"comments": [{
				"id": 2,
				"body": "That makes no sense at all",
				"para_id": 2
			}]
		}
	}
  <b>Revision history</b><br>
=end
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
