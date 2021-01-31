# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]

  def login
    @user = User.find_by(username: params[:username])

    if @user&.authenticate(params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { user: @user.as_json(only: %i[id username]), token: token }
    else
      render json: { error: 'Invalid username or password' }
    end
  end

  def auto_login
    render json: @user.as_json(only: %i[id username])
  end

  private

  def user_params
    params.permit(:username, :password, :age)
  end
end
