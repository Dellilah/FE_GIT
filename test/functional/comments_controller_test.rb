require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  test "should get add" do
    get :add
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

end
