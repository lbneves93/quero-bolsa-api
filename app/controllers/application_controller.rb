# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authorized, except: :home

  def home
    render html: '<center><h1>Bem vindo a Quero Bolsa API!</h1></center>'.html_safe
  end

  def encode_token(payload)
    
    JWT.encode(payload, Rails.application.credentials.dig(Rails.env.to_sym, :jwt_secret).to_s)
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    return unless auth_header

    token = auth_header.split(' ')[1]
    begin
      JWT.decode(token, Rails.application.credentials.dig(Rails.env.to_sym, :jwt_secret).to_s, true, algorithm: 'HS256')
    rescue JWT::DecodeError
      nil
    end
  end

  def logged_in_user
    return unless decoded_token

    user_id = decoded_token[0]['user_id']
    @user = User.find_by(id: user_id)
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
