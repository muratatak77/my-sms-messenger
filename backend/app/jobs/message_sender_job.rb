# Job responsible for sending messages asynchronously using Twilio.
class MessageSenderJob < ApplicationJob
  queue_as :default

  # Performs the job to send a message.
  # Finds the message by ID and sends it via TwilioMessageSender.
  # If an error occurs, logs the error and updates the message status to "failed".
  def perform(message_id)
    message = Message.find(message_id)
    TwilioMessageSender.send(message)
  rescue => e
    Rails.logger.error("MessageSenderJob failed: #{e.message}")
    message.update(status: "failed") if message
  end
end
