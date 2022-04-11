class Property < ApplicationRecord
  before_save {name.capitalize!}
  
  validates :stock, presence: true
  validates :stock, numericality: { greater_than_or_equal_to: 0 }
  validates :name, presence: true, uniqueness: { scope: [:variation_id], case_sensitive: false }

  belongs_to :variation

  has_many :order_items
  has_many :orders, through: :order_items


  def full_name
    return "#{self.variation.title} #{self.name}"
  end

  def price
    return self.variation.product.price
  end
  
end
