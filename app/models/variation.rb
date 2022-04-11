class Variation < ApplicationRecord
  belongs_to :product
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  
  has_many :properties, dependent: :destroy

  def total_stock
    sum = 0
    properties.each do |p|
      sum += p.stock
    end
    
    return sum
  end
end
