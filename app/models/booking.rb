class Booking < ApplicationRecord
  belongs_to :listing
  belongs_to :renter, class_name: "User"
  has_many :reviews, dependent: :destroy
  has_one :adventure, dependent: :destroy

  enum :status, { requested: 0, approved: 1, declined: 2, active: 3, completed: 4, cancelled: 5 }

  delegate :owner, to: :listing

  before_validation :snapshot_pricing, on: :create

  validates :start_on, :end_on, presence: true
  validate :end_on_not_before_start_on
  validate :renter_is_not_owner

  def approve!
    update!(status: :approved, approved_at: Time.current) if requested?
  end

  def decline!
    update!(status: :declined, declined_at: Time.current) if requested?
  end

  def pick_up!
    update!(status: :active, picked_up_at: Time.current) if approved?
  end

  def return!
    update!(status: :completed, returned_at: Time.current) if active?
  end

  def cancel!
    update!(status: :cancelled, cancelled_at: Time.current) if requested? || approved?
  end

  private

  def snapshot_pricing
    return unless listing
    self.days = (end_on - start_on).to_i + 1 if start_on && end_on
    self.daily_rate_cents = listing.price_per_day_cents
    self.deposit_cents = listing.deposit_cents
    self.currency = listing.currency
    self.subtotal_cents = days * daily_rate_cents if days && daily_rate_cents
  end

  def end_on_not_before_start_on
    if start_on && end_on && end_on < start_on
      errors.add(:end_on, "must be on or after the start date")
    end
  end

  def renter_is_not_owner
    errors.add(:renter, "can't book your own gear") if renter_id == listing&.owner_id
  end
end
