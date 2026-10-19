class Listing < ApplicationRecord
  CURRENCIES = %w[EUR USD GBP CHF].freeze


  belongs_to :owner, class_name: "User"
  belongs_to :category
  has_many :bookings, dependent: :destroy
  has_many :gear_logs, -> { order(happened_on: :desc) }, dependent: :destroy, inverse_of: :listing
  has_many_attached :photos

  enum :condition, { brand_new: 0, like_new: 1, good: 2, well_loved: 3 }
  enum :status, { draft: 0, active: 1, paused: 2, archived: 3 }

  validates :title, :location_text, presence: true
  validates :price_per_day_cents, :deposit_cents, numericality: { greater_than_or_equal_to: 0 }
  validates :currency, inclusion: { in: CURRENCIES }

  def price_per_day
    price_per_day_cents / 100.0
  end

  def price_per_day=(value)
    self.price_per_day_cents = (value.to_f * 100).round
  end

  def deposit
    deposit_cents / 100.0
  end

  def deposit=(value)
    self.deposit_cents = (value.to_f * 100).round
  end
end
