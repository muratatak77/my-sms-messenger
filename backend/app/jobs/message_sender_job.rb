class MessageSenderJob < ApplicationJob
  queue_as :default

  def perform(message_id)
    message = Message.find(message_id)
    TwilioMessageSender.send(message)
  rescue => e
    Rails.logger.error("MessageSenderJob failed: #{e.message}")
    message.update(status: "failed") if message
  end
end
