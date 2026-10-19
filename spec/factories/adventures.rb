FactoryBot.define do
  factory :adventure do
    booking { nil }
    user { nil }
    title { "MyString" }
    body { "MyText" }
    location_text { "MyString" }
    happened_on { "2026-10-19" }
  end
end
