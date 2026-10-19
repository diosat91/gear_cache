require "rails_helper"

RSpec.describe "Listings", type: :request do
  let(:owner) { create(:user) }
  let!(:listing) { create(:listing, owner: owner) }

  it "browses active listings" do
    get listings_path
    expect(response).to have_http_status(:ok)
    expect(response.body).to include(listing.title)
  end

  it "requires auth to create" do
    get new_listing_path
    expect(response).to redirect_to(new_user_session_path)
  end

  it "lets a signed-in user create a listing" do
    sign_in owner
    category = create(:category)

    expect {
      post listings_path, params: {
        listing: {
          title: "Petzl GriGri+", category_id: category.id,
          location_text: "Denver, CO", price_per_day: "10", deposit: "50"
        }
      }
    }.to change(Listing, :count).by(1)

    created = Listing.last
    expect(created.owner).to eq(owner)
    expect(created.price_per_day_cents).to eq(1000)
  end

  it "keeps photos attached when updating without new files" do
    sign_in owner
    listing.photos.attach(
      io: File.open(Rails.root.join("spec/fixtures/files/pixel.png")),
      filename: "pixel.png", content_type: "image/png"
    )

    patch listing_path(listing), params: {
      listing: { title: "Renamed", photos: [""] }
    }

    expect(listing.reload.photos.attachments.count).to eq(1)
  end

  it "hides archived listings from browse" do
    listing.update!(status: :archived)
    get listings_path
    expect(response.body).not_to include(listing.title)
  end
end
