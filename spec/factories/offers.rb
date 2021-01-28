FactoryBot.define do
  factory :offer do
    association :course
    full_price { rand(1500.00...2000.00).round(2) }
    price_with_discount { rand(1000.00...1499.00).round(2) }
    discount_percentage { rand(5.00...40.00).round(2) } 
    start_date { rand(Date.today...Date.today+30.days) }
    enrollment_semester { ['2021.1', '2021.2'].sample } 
    enabled { true }
  end
end
