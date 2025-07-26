# Controller to handle incoming webhook requests from external services (e.g., Twilio).
# Currently supports updating message status based on Twilio callbacks.
class Api::WebhooksController < ApplicationController
  # Receives status updates from Twilio for sent messages.
  # Expects 'MessageSid' and 'MessageStatus' in the params.
  # Finds the corresponding Message by SID and updates its status.
  # Always responds with HTTP 200 OK.
  def twilio_status
    message_sid = params["MessageSid"]
    message_status = params["MessageStatus"]
    message = Message.find_by(sid: message_sid)
    if message
      message.update(status: message_status)
    end
    head :ok
  end
end
