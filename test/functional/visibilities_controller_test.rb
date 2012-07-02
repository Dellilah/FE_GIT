require 'test_helper'

class VisibilitiesControllerTest < ActionController::TestCase
  test "should get changevisibility_form" do
    get :changevisibility_form
    assert_response :success
  end

  test "should get change_visibility" do
    get :change_visibility
    assert_response :success
  end

end
