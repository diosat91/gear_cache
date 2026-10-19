FactoryBot.define do
  factory :booking do
    listing { nil }
    renter { nil }
    start_on { "2026-10-19" }
    end_on { "2026-10-19" }
    status { 1 }
    daily_rate_cents { 1 }
    days { 1 }
    subtotal_cents { 1 }
    deposit_cents { 1 }
    approved_at { "2026-10-19 18:33:10" }
    declined_at { "2026-10-19 18:33:10" }
    picked_up_at { "2026-10-19 18:33:10" }
    returned_at { "2026-10-19 18:33:10" }
    cancelled_at { "2026-10-19 18:33:10" }
  end
end
