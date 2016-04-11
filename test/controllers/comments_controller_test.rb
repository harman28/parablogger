require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  test "create a post" do
    assert_difference('Posts::Paragraphs::Comment.count') do
      response = post :new, {paragraph_id: 2, body: 'test comment'}
      compact = JSON.parse(response.body)['result']
      compact_tester(compact)
    end
  end
end
