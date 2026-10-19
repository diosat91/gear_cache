FactoryBot.define do
  factory :booking do
    listing
    renter { association(:user) }
    start_on { Date.current + 7 }
    end_on { Date.current + 9 }
  end
end
