require "test_helper"
require "minitest/mock"

class TwilioMessageSenderTest < ActiveSupport::TestCase
  test "sends SMS via Messaging Service SID" do
    user = User.first || User.create!(username: "test@example.com", password: "password")
    message = Message.create!(
      to: ENV["TWILIO_TARGET_NUMBER"],
      body: "Messaging Service Test",
      user: user
    )

    # Fake mesaj handler (instance method create)
    fake_messages = Class.new {
      def create(messaging_service_sid:, to:, body:)
        raise "Wrong SID" unless messaging_service_sid == ENV["TWILIO_MESSAGING_SERVICE_SID"]
        raise "Wrong recipient" unless to == ENV["TWILIO_TARGET_NUMBER"]
        raise "Wrong body" unless body == "Messaging Service Test"
        true
      end
    }.new

    # Fake Twilio client
    fake_client = Class.new {
      define_method(:messages) { fake_messages }
    }.new

    # Stub Twilio client
    Twilio::REST::Client.stub(:new, fake_client) do
      TwilioMessageSender.send(message)
    end

    assert_equal "sent", message.reload.status
  end
end
