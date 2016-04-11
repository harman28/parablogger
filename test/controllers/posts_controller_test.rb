require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  test "index page" do
    limit = 2
    response = get(:index, {page:1, limit:limit} )
    assert_response :success
    result = JSON.parse(response.body)['result']
    assert result.length <= limit
    assert_empty (['id','title'] - result.first.keys)
  end

  test "show page" do
    response = get(:show, {id:1} )
    assert_response :success
    compact = JSON.parse(response.body)['result']
    compact_tester(compact)
  end

  test "create a post" do
    assert_difference('Post.count') do
      post :new, {title: 'Test post', body: 'Single para post.'}
    end
  end
end
