# frozen_string_literal: true

class University < ApplicationRecord
  has_many :campus, dependent: :destroy
end
