class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: %i[approve decline pickup dropoff cancel]
  before_action :authorize_owner!, only: %i[approve decline pickup dropoff]
  before_action :authorize_renter!, only: %i[cancel]

  def index
    @bookings = current_user.bookings.includes(listing: :owner).order(created_at: :desc)
  end

  def requests
    @bookings = Booking.joins(:listing)
                       .where(listings: { owner_id: current_user.id })
                       .includes(:renter, :listing)
                       .order(created_at: :desc)
  end

  def create
    @listing = Listing.find(params[:listing_id])
    @booking = @listing.bookings.build(booking_params)
    @booking.renter = current_user

    if @booking.save
      redirect_to bookings_path, notice: "Request sent to #{@listing.owner.name}."
    else
      redirect_to @listing, alert: @booking.errors.full_messages.to_sentence
    end
  end

  def approve
    @booking.approve!
    redirect_to requests_bookings_path, notice: "Booking approved."
  end

  def decline
    @booking.decline!
    redirect_to requests_bookings_path, notice: "Booking declined."
  end

  def pickup
    @booking.pick_up!
    redirect_to requests_bookings_path, notice: "Marked as picked up."
  end

  def dropoff
    @booking.return!
    redirect_to requests_bookings_path, notice: "Gear returned — booking complete."
  end

  def cancel
    @booking.cancel!
    redirect_to bookings_path, notice: "Booking cancelled."
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def authorize_owner!
    redirect_to root_path, alert: "Not your booking." unless @booking.owner == current_user
  end

  def authorize_renter!
    redirect_to root_path, alert: "Not your booking." unless @booking.renter == current_user
  end

  def booking_params
    params.expect(booking: [:start_on, :end_on])
  end
end
