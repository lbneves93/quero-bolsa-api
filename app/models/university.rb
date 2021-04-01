# frozen_string_literal: true

class University < ApplicationRecord
  has_many :campus, class_name: 'Campus', dependent: :destroy
end
