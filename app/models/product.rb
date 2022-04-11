class Product < ApplicationRecord
  belongs_to :category

  has_many :variations, dependent: :destroy

  def total_stock
    sum = 0
    variations.each do |v|
      sum += v.total_stock
    end

    return sum
  end

  def all_variation
    a = self.variations.pluck(:id)
    return Property.where(variation_id: a).where('stock > 0')
  end
  
end
