require "rails_helper"

RSpec.describe "Bookings", type: :request do
  let(:owner) { create(:user) }
  let(:renter) { create(:user) }
  let!(:listing) { create(:listing, owner: owner) }

  it "lets a renter request a booking" do
    sign_in renter

    expect {
      post listing_bookings_path(listing), params: {
        booking: { start_on: "2026-11-01", end_on: "2026-11-03" }
      }
    }.to change(Booking, :count).by(1)

    expect(Booking.last.renter).to eq(renter)
  end

  it "lets the owner approve" do
    booking = create(:booking, listing: listing, renter: renter)
    sign_in owner
    patch approve_booking_path(booking)
    expect(booking.reload).to be_approved
  end

  it "blocks the renter from approving their own request" do
    booking = create(:booking, listing: listing, renter: renter)
    sign_in renter
    patch approve_booking_path(booking)
    expect(booking.reload).to be_requested
  end

  it "lets the renter cancel a pending request" do
    booking = create(:booking, listing: listing, renter: renter)
    sign_in renter
    patch cancel_booking_path(booking)
    expect(booking.reload).to be_cancelled
  end
end
