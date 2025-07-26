require "test_helper"

class MessageTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(username: "testuser", password: "secret123", password_confirmation: "secret123")
  end

  test "should save a valid message" do
    message = Message.new(to: "+1234567890", body: "Hello", user: @user)
    assert message.save, "Valid message was not saved"
  end

  test "should not save message with invalid status" do
    message = Message.new(to: "+1234567890", body: "Hello", user: @user, status: "unknown")
    assert_not message.save, "Message with invalid status was saved"
    assert_includes message.errors[:status], "is not included in the list"
  end

  test "should respond to status query methods" do
    message = Message.new(to: "+1234567890", body: "Hi", user: @user, status: "delivered")
    assert message.delivered?
    assert_not message.failed?
  end

  test "should return correct scope results" do
    Message.create!(to: "+111", body: "A", user: @user, status: "pending")
    Message.create!(to: "+222", body: "B", user: @user, status: "delivered")

    assert_equal 1, Message.pending.count
    assert_equal 1, Message.delivered.count
  end

  test "user should have many messages" do
    msg1 = Message.create!(to: "+111", body: "Hi", user: @user)
    msg2 = Message.create!(to: "+222", body: "Hello", user: @user)

    assert_equal 2, @user.messages.count
    assert_includes @user.messages, msg1
    assert_includes @user.messages, msg2
  end

  test "messages should be destroyed when user is deleted" do
    @user.messages.create!(to: "+333", body: "Bye", status: "sent")
    assert_difference("Message.count", -1) do
      @user.destroy
    end
  end
end
