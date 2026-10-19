class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :trackable, :lockable, :omniauthable

  has_many :listings, foreign_key: :owner_id, dependent: :destroy, inverse_of: :owner
  has_many :bookings, foreign_key: :renter_id, dependent: :destroy, inverse_of: :renter
  has_many :reviews_given, class_name: "Review", foreign_key: :reviewer_id, dependent: :destroy, inverse_of: :reviewer
  has_many :reviews_received, class_name: "Review", foreign_key: :reviewee_id, dependent: :destroy, inverse_of: :reviewee
  has_many :adventures, dependent: :destroy
  has_many :kudos_given, class_name: "Kudo", foreign_key: :giver_id, dependent: :destroy, inverse_of: :giver
  has_many :kudos_received, class_name: "Kudo", foreign_key: :receiver_id, dependent: :destroy, inverse_of: :receiver

  validates :name, presence: true
end
