FactoryBot.define do
  factory :review do
    booking { nil }
    reviewer { nil }
    reviewee { nil }
    rating { 1 }
    body { "MyText" }
  end
end
