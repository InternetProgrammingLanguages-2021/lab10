require "test_helper"

class ChunksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get chunks_index_url
    assert_response :success
  end

  test "should get xml without ssr" do
    get "#{chunks_index_url}?q=1,2,3&ssr=false", as: :xml
    assert_response :success
    assert_equal 'application/xml', @response.media_type
  end

  test "should get html with ssr" do
    get "#{chunks_index_url}?q=1,2,3&ssr=true", as: :xml
    assert_response :success
    assert_equal 'text/html', @response.media_type
  end
end
