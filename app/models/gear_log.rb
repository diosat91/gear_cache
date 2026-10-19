class GearLog < ApplicationRecord
  belongs_to :listing

  enum :kind, { purchase: 0, fall: 1, inspection: 2, repair: 3, retirement: 4, note: 5 }

  validates :happened_on, presence: true
end
