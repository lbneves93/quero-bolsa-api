# frozen_string_literal: true

class ApplicationController < ActionController::API
  def home
    render html: '<center><h1>Bem vindo a Quero Bolsa API!</h1></center>'.html_safe
  end
end
