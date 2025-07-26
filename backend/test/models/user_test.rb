require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save user without username" do
    user = User.new(password: "secret123")
    assert_not user.save, "Saved the user without a username"
  end

  test "should save valid user" do
    user = User.new(username: "validuser", password: "secret123")
    assert user.save, "Could not save a valid user"
  end

  test "should not allow duplicate username" do
    User.create!(username: "duplicate", password: "secret123")
    user = User.new(username: "duplicate", password: "another123")
    assert_not user.save, "Saved a user with duplicate username"
  end
end
