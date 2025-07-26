require "test_helper"

class Api::MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Create a user for authentication
    @user = User.create!(
      username: "test@example.com",
      password: "password",
      password_confirmation: "password"
    )

    # Log in to get the JWT token
    post "/api/login", params: { username: @user.username, password: "password" }

    # Ensure login succeeded
    assert_response :success, "Login failed during test setup"

    # Parse and store the token
    @token = JSON.parse(response.body)["token"]
    assert_not_nil @token, "Token was not returned from login"
  end

  test "should create message and enqueue job" do
    # Ensure the MessageSenderJob is enqueued when creating a message
    assert_enqueued_with(job: MessageSenderJob) do
      post "/api/messages",
        params: { message: { body: "Hello world" } },
        headers: { "Authorization" => "Bearer #{@token}" }

      # Expect a successful creation response
      assert_response :created

      # Parse and verify the response body
      json = JSON.parse(response.body)
      assert_equal "Message sent", json["message"]
      assert_equal "Hello world", json["data"]["body"]
    end
  end
end
