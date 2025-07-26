class Api::WebhooksController < ApplicationController
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
