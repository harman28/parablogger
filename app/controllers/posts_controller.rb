class PostsController < ApplicationController
	include ApplicationHelper

	skip_before_action :verify_authenticity_token

=begin
  :method: index
  <b>Common Name</b> Posts Index<br>
  <b>Short Description</b> Returns compact posts in paginated form<br>
  <b>Endpoints</b> Web<br>
  <b>Request Type</b> GET<br>
  <b>Route </b> /posts/<br>
  <b>Authentication Required</b> Public<br>
  <b>Request Format</b>
	/posts?page=1&limit=2
  <b>Response Format</b> A json array containing list of society objects<br>
    {
		"status": "OK",
		"message": "success",
		"result": [{
			"id": 1,
			"title": "First Post Ever"
		}, {
			"id": 2,
			"title": "Second Post"
		}]
	}
  <b>Revision history</b><br>
=end
	def index
		page = params[:page] || 1
		per_page = params[:limit] || 5
		result = Post.select_compact.paginate(page: page,per_page: per_page)
		process_response(result, 200, params)
	end

=begin
  :method: show
  <b>Common Name</b> Posts Show<br>
  <b>Short Description</b> Returns post info with comments<br>
  <b>Endpoints</b> Web<br>
  <b>Request Type</b> GET<br>
  <b>Route </b> /posts/:id<br>
  <b>Authentication Required</b> Public<br>
  <b>Request Format</b>
    /posts/1
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
	def show
		post = Post.find_by(id:params[:id])
		if post.present?
			result = post.compact
			status = 200
		else
			result = { message: "Not Found"}
			status = 400
		end
		process_response(result, status, params)
	end

=begin
  :method: new
  <b>Common Name</b> Post a new Post<br>
  <b>Short Description</b> Creates a new post<br>
  <b>Endpoints</b> Web<br>
  <b>Request Type</b> POST<br>
  <b>Route </b> /posts/<br>
  <b>Authentication Required</b> Public<br>
  <b>Request Format</b>
    {
	  "title": "First Post Ever",
	  "body": "This is the first post ever.\n\nIt's a great post because it has multiple paragraphs.\n\nMost of them are separated by 2 newlines.\nBut some are not.\n\n\nSome are separated by more.\n\nBas.\n"
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
				"body": "Bas.\n"
			}],
			"comments": []
		}
	}
  <b>Revision history</b><br>
=end
	def new
		post = Post.new(title:params[:title])
		if post.save
			begin
				body = params[:body]
				para_array = body.gsub(/\n\n(\n)+/,"\n\n").split("\n\n")
				insert_list = []
				para_array.each_with_index do |para,index|
					insert_list << Posts::Paragraph.new(body:para, post_id:post.id, order_id:index)
				end
				Posts::Paragraph.import insert_list
				result = post.compact
				status = 200
			rescue
				post.destroy!
				result = { message: "Error. Invalid body." }
				status = 400
			end
		else
			result = { message: "Error. Invalid post." }
			status = 400
		end
		process_response(result, status, params)
	end
end
