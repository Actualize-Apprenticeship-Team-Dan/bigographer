require 'test_helper'

class CodeTest < ActiveSupport::TestCase
  test "generate url" do
    url = Code.generate_url
    assert_equal 8, url.length
  end
end
