class Listing < ApplicationRecord
  belongs_to :owner, class_name: "User"
  belongs_to :category
  has_many :bookings, dependent: :destroy
  has_many :gear_logs, -> { order(happened_on: :desc) }, dependent: :destroy, inverse_of: :listing
  has_many_attached :photos

  enum :condition, { brand_new: 0, like_new: 1, good: 2, well_loved: 3 }
  enum :status, { draft: 0, active: 1, paused: 2, archived: 3 }

  validates :title, :location_text, presence: true
  validates :price_per_day_cents, :deposit_cents, numericality: { greater_than_or_equal_to: 0 }
end
