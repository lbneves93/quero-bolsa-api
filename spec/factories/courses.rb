FactoryBot.define do
  factory :course do
    name { FFaker::Education.degree }
    kind { ['distance learning', 'presential'].sample }
    level { ['bachelor', 'master', 'technologist', 'graduation'].sample }
    shift { ['morning', 'afternoon', 'night'].sample }
  end
end
