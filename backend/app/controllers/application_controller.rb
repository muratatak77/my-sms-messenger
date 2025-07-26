class ApplicationController < ActionController::API
  # Exposes the currently authenticated user.
  attr_reader :current_user

  # Before-action filter to authorize API requests using JWT.
  # Extracts token from the 'Authorization' header, decodes it,
  # and sets @current_user if valid. Renders 401 if invalid.
  def authorize_request
    header = request.headers["Authorization"]
    token = header.split(" ").last if header
    decoded = JsonWebToken.decode(token)
    @current_user = User.find(decoded[:user_id]) if decoded
  rescue => e
    # Logs authorization errors and returns unauthorized response.
    Rails.logger.error("Authorization failed: #{e.class} - #{e.message}")
    Rails.logger.error(e.backtrace.join("\n"))
    render json: { error: "Unauthorized" }, status: :unauthorized
  end
end
