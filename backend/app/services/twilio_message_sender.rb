class TwilioMessageSender
  # Sends an SMS message using the Twilio API.
  # Updates the message status and SID on success.
  # On Twilio errors, updates status to "failed" and logs the error.
  def self.send(message)
    client = Twilio::REST::Client.new(
      ENV["TWILIO_ACCOUNT_SID"],
      ENV["TWILIO_AUTH_TOKEN"]
    )

    # Determine callback base URL depending on environment.
    callback_base = if Rails.env.development?
                      ENV["TWILIO_STATUS_CALLBACK"]
    else
                      ENV["BASE_URL"]
    end

    # Send the message via Twilio.
    twilio_message = client.messages.create(
      messaging_service_sid: ENV["TWILIO_MESSAGING_SERVICE_SID"],
      to: message.to,
      body: message.body,
      status_callback: "#{callback_base}/webhooks/twilio-status"
    )

    # Update message record with status and Twilio SID.
    message.update(status: "sent", sid: twilio_message.sid)
  rescue Twilio::REST::RestError => e
    # On error, mark as failed and log the error.
    message.update(status: "failed")
    Rails.logger.error("Twilio Error: #{e.message}")
  end
end
