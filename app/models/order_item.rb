class OrderItem < ApplicationRecord
  belongs_to :property
  belongs_to :order

  def product
    return self.property.variation.product
  end
end
