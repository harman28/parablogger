ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def compact_tester compact
    assert_empty (['id','title','paras','comments'] - compact.keys)
    paras = compact['paras']
    comments = compact['comments']
    assert paras.is_a?(Array) && comments.is_a?(Array)
    assert_empty (['id','order_id','body'] - paras.first.keys) if paras.length > 0
    assert_empty (['id','para_id','body'] - comments.first.keys) if comments.length > 0
  end
end
