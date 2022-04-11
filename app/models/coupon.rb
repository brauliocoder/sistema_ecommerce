class Coupon < ApplicationRecord
  before_save {code.upcase!.gsub!(' ','-')}

  validates :code, uniqueness: true
  validates_presence_of :code, :discount, :discount_type
  validates :discount_type, inclusion: { in: %w(percentage ammount) }
  validates_inclusion_of :discount, :in => 1..100, if: :type_is_percentage?, :message => "can't equal to 0 or be greater than 100"
  validates :discount, numericality: { greater_than: 0 }

  has_many :orders

  def type_is_percentage?
    if discount_type == "percentage"
      return true
    else
      return false
    end
  end
end
