FactoryGirl.define do
  factory :city do
    name { Faker::Address.city }
  end

  factory :route do
    association :source_city, factory: :city
    association :destination_city, factory: :city
    distance Faker::Number.between(1, 9)
  end
end
