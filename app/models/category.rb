class Category < ApplicationRecord
  belongs_to :parent, class_name: "Category", optional: true
  has_many :subcategories, class_name: "Category", foreign_key: :parent_id, dependent: :destroy, inverse_of: :parent
  has_many :listings, dependent: :nullify

  before_validation :set_slug

  validates :name, :slug, presence: true
  validates :slug, uniqueness: true

  private

  def set_slug
    self.slug = name.parameterize if slug.blank? && name.present?
  end
end
