FactoryBot.define do
  factory :gear_log do
    listing { nil }
    kind { 1 }
    body { "MyText" }
    happened_on { "2026-10-19" }
  end
end
