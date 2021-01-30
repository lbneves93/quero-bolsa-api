# frozen_string_literal: true

FactoryBot.define do
  factory :campus do
    association :university
    name { FFaker::Education.school_generic_name }
    city { FFaker::Address.city }
  end
end
