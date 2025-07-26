class Api::AuthController < ApplicationController
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
