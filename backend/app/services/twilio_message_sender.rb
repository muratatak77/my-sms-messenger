class TwilioMessageSender
  def self.send(message)
    client = Twilio::REST::Client.new(
      ENV["TWILIO_ACCOUNT_SID"],
      ENV["TWILIO_AUTH_TOKEN"]
    )

    callback_base = if Rails.env.development?
                      ENV["TWILIO_STATUS_CALLBACK"]
    else
                      ENV["BASE_URL"]
    end

    twilio_message = client.messages.create(
      messaging_service_sid: ENV["TWILIO_MESSAGING_SERVICE_SID"],
      to: message.to,
      body: message.body,
      status_callback: "#{callback_base}/webhooks/twilio-status"
    )

    message.update(status: "sent", sid: twilio_message.sid)
  rescue Twilio::REST::RestError => e
    message.update(status: "failed")
    Rails.logger.error("Twilio Error: #{e.message}")
  end
end
