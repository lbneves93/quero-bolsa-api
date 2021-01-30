# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    name { FFaker::Education.degree }
    kind { ['distance learning', 'presential'].sample }
    level { %w[bachelor master technologist graduation].sample }
    shift { %w[morning afternoon night].sample }
  end
end
