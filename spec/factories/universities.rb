# frozen_string_literal: true

FactoryBot.define do
  factory :university do
    name { FFaker::Education.school }
    score { rand(1.0...5.0).round(2) }
    logo_url { FFaker::Image.url }
  end
end
