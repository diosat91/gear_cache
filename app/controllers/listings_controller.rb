class ListingsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_listing, only: %i[show edit update destroy]
  before_action :authorize_owner!, only: %i[edit update destroy]

  def index
    @categories = Category.where(parent: nil).includes(:subcategories).order(:name)
    @listings = Listing.active.includes(:category, :owner).order(created_at: :desc)

    if params[:category].present?
      category = Category.find_by(slug: params[:category])
      ids = [category&.id, *category&.subcategories&.ids].compact
      @listings = @listings.where(category_id: ids) if category
    end

    if params[:location].present?
      @listings = @listings.where("location_text LIKE ?", "%#{params[:location]}%")
    end

    if params[:q].present?
      @listings = @listings.where("title LIKE ? OR description LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
    end
  end

  def show
    @booking = Booking.new
    @my_request = current_user && @listing.bookings.find_by(renter: current_user, status: %i[requested approved active])
  end

  def mine
    @listings = current_user.listings.includes(:category).order(created_at: :desc)
  end

  def new
    @listing = current_user.listings.build
  end

  def create
    @listing = current_user.listings.build(listing_params)
    if @listing.save
      redirect_to @listing, notice: "Listing created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @listing.update(listing_params)
      redirect_to @listing, notice: "Listing updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @listing.update!(status: :archived)
    redirect_to mine_listings_path, notice: "Listing archived."
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def authorize_owner!
    redirect_to @listing, alert: "Not your listing." unless @listing.owner == current_user
  end

  def listing_params
    permitted = params.expect(listing: [:title, :description, :brand, :category_id, :condition,
                                        :safety_critical, :price_per_day, :deposit, :currency,
                                        :location_text, :status, { photos: [] }])

    # An empty multi-file field submits photos: [""], which purges all
    # attachments. Drop the key when nothing was actually selected.
    permitted.delete(:photos) if permitted[:photos].is_a?(Array) && permitted[:photos].all?(&:blank?)
    permitted
  end
end
