require "rails_helper"

RSpec.describe Booking, type: :model do
  let(:booking) { create(:booking) }

  it "snapshots listing pricing on create" do
    expect(booking.days).to eq(3)
    expect(booking.daily_rate_cents).to eq(booking.listing.price_per_day_cents)
    expect(booking.subtotal_cents).to eq(3 * booking.listing.price_per_day_cents)
    expect(booking.deposit_cents).to eq(booking.listing.deposit_cents)
    expect(booking.currency).to eq(booking.listing.currency)
  end

  it "walks the happy path" do
    expect(booking).to be_requested
    booking.approve!
    expect(booking).to be_approved
    booking.pick_up!
    expect(booking).to be_active
    booking.return!
    expect(booking).to be_completed
    expect(booking.returned_at).to be_present
  end

  it "can be declined or cancelled from requested" do
    booking.decline!
    expect(booking).to be_declined

    other = create(:booking)
    other.cancel!
    expect(other).to be_cancelled
  end

  it "doesn't let renters book their own gear" do
    listing = create(:listing)
    expect(build(:booking, listing: listing, renter: listing.owner)).not_to be_valid
  end

  it "rejects an end date before the start date" do
    expect(build(:booking, start_on: Date.current + 5, end_on: Date.current + 2)).not_to be_valid
  end
end
