require 'test_helper'

class Posts::ParagraphTest < ActiveSupport::TestCase
  test "comments association" do
    para = Posts::Paragraph.first
    assert_instance_of Posts::Paragraphs::Comment::ActiveRecord_Associations_CollectionProxy, para.comments
  end

  test "post association" do
    para = Posts::Paragraph.find_by(body:'Some are separated by more.')
    assert para.post.present?
    assert_match /First Post Ever/, para.post.title
  end
end
