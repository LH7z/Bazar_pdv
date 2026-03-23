class ProductVariant < ApplicationRecord
  belongs_to :product
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy

  before_create :generate_sku

  private

  def generate_sku
    return unless product&.name.present? && size.present? && color.present?

    self.sku = "#{product.name[0..2].upcase}-#{size[0..1].upcase}-#{color[0..1].upcase}-#{SecureRandom.hex(4).upcase}"
  end
end
