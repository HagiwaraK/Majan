require "test_helper"

class SummaryControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get summary_show_url
    assert_response :success
  end
end
