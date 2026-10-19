class Adventure < ApplicationRecord
  belongs_to :booking
  belongs_to :user
  has_many_attached :photos

  validates :title, presence: true
end
