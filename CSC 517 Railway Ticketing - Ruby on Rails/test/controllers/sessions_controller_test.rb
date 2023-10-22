require "test_helper"
class SessionsControllerTest < ActionController::TestCase
  test "should create session for admin" do
    admin = admins(:admin_user)
    post :create, params: { email_address: admin.email, password: 'password' }

    assert session[:user_id] == admin.id
    assert session[:admin] == true
    assert_redirected_to root_url
  end

  test "should create session for passenger" do
    passenger = passengers(:passenger_user)
    post :create, params: { email_address: passenger.email, password: 'password' }

    assert session[:user_id] == passenger.id
    assert session[:admin] == false
    assert_redirected_to root_url
  end

  test "should destroy session" do
    session[:user_id] = 123

    delete :destroy

    assert_nil session[:user_id]
    assert_redirected_to root_url
  end
end
