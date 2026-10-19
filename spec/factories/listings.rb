FactoryBot.define do
  factory :listing do
    owner { nil }
    category { nil }
    title { "MyString" }
    description { "MyText" }
    brand { "MyString" }
    condition { 1 }
    safety_critical { false }
    price_per_day_cents { 1 }
    deposit_cents { 1 }
    location_text { "MyString" }
    status { 1 }
  end
end
