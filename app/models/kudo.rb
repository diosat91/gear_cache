class Kudo < ApplicationRecord
  belongs_to :giver, class_name: "User"
  belongs_to :receiver, class_name: "User"
  belongs_to :booking, optional: true
  belongs_to :adventure, optional: true

  validate :giver_is_not_receiver

  private

  def giver_is_not_receiver
    errors.add(:receiver, "can't give kudos to yourself") if giver_id == receiver_id
  end
end
