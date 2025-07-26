class Api::MessagesController < ApplicationController
  # Require user to be authorized before accessing any action
  before_action :authorize_request

  # GET /api/messages
  def index
    messages = current_user.messages.order(created_at: :desc)
    render json: messages
  end

  # POST /api/messages
  def create
    # Initialize a new message with permitted parameters
    message = Message.new(message_params)

    # Assign the target phone number and the current user
    message.to = ENV["TWILIO_TARGET_NUMBER"]
    message.user = current_user

    # Save the message and enqueue background job
    if message.save
      MessageSenderJob.perform_later(message.id)
      render json: { message: "Message sent", data: message }, status: :created
    else
      render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  # Only allow the body field from the request
  def message_params
    params.require(:message).permit(:body)
  end
end
