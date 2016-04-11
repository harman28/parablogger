require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "Title validation" do
    post = Post.new
    assert_not post.save
    post.assign_attributes(title:'Token Title')
    assert post.save
  end

  test "paragraphs association" do
    post = Post.first
    assert_instance_of Posts::Paragraph::ActiveRecord_Associations_CollectionProxy, post.paragraphs
  end

  test "compact response" do
    compact = Post.first.compact
    compact_tester(compact)
  end
end
