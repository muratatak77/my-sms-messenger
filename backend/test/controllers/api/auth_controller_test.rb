require "test_helper"

class Api::AuthControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(username: "testuser", password: "securepass", password_confirmation: "securepass")
  end

  test "should login with valid credentials and return token" do
    post "/api/login", params: { username: "testuser", password: "securepass" }
    assert_response :success
    body = JSON.parse(response.body)
    assert body["token"].present?
    assert_equal "Login successful", body["message"]
  end

  test "should not login with incorrect password" do
    post "/api/login", params: { username: "testuser", password: "wrongpass" }
    assert_response :unauthorized
    body = JSON.parse(response.body)
    assert_equal "Invalid username or password", body["error"]
  end

  test "should not login with non-existent user" do
    post "/api/login", params: { username: "ghost", password: "whatever" }
    assert_response :unauthorized
    body = JSON.parse(response.body)
    assert_equal "Invalid username or password", body["error"]
  end
end
