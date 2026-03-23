class Product < ApplicationRecord
  has_many :product_variants, dependent: :destroy
  has_one_attached :image

  accepts_nested_attributes_for :product_variants, reject_if: :all_blank, allow_destroy: true

  validates :name, :price, presence: true
end
