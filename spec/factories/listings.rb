FactoryBot.define do
  factory :listing do
    owner { association(:user) }
    category
    title { "BD Camalots, full rack" }
    description { "Well-maintained set, used ~2 seasons." }
    brand { "Black Diamond" }
    condition { :good }
    location_text { "Boulder, CO" }
    price_per_day_cents { 2500 }
    deposit_cents { 10000 }
    status { :active }
  end
end
