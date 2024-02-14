class SessionsController < ApplicationController
  def create
    user = User.find_by(user_name: params[:username])

    if user&.authenticate(params[:password])
      token = "test"
      render json: { token: token }, status: :ok
    else
      render json {error: "unauthorized", status: :unauthorized}
    end
  end

  private 
  def jwt_encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, Rails.application.ssecret_key_base)
  end
end