class Offer < ApplicationRecord
  belongs_to :course
  belongs_to :campus
  delegate :university, to: :campus
end
