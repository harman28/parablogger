require 'test_helper'

class Posts::Paragraphs::CommentTest < ActiveSupport::TestCase
  test "paragraph association" do
    comment = Posts::Paragraphs::Comment.find_by(body:'This is true.')
    assert comment.paragraph.present?
    assert_match /It's not quite as good./, comment.paragraph.body
  end
end
