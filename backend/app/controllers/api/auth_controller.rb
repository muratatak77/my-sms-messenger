# Controller responsible for user authentication actions.
class Api::AuthController < ApplicationController
  # Handles user login.
  # Expects :username and :password in the params.
  # If authentication succeeds, returns a JWT token and user info.
  # If authentication fails, returns an error with status 401.
  def login
    user = User.where(username: params[:username]).first

    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { message: "Login successful", token: token, user: { username: user.username } }, status: :ok
    else
      render json: { error: "Invalid username or password" }, status: :unauthorized
    end
  end
end
