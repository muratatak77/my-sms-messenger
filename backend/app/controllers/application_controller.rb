class ApplicationController < ActionController::API
  attr_reader :current_user

  def authorize_request
    header = request.headers["Authorization"]
    token = header.split(" ").last if header
    decoded = JsonWebToken.decode(token)
    @current_user = User.find(decoded[:user_id]) if decoded
  rescue => e
    Rails.logger.error("Authorization failed: #{e.class} - #{e.message}")
    Rails.logger.error(e.backtrace.join("\n"))
    render json: { error: "Unauthorized" }, status: :unauthorized
  end
end
