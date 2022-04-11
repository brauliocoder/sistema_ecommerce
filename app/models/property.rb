class Property < ApplicationRecord
  before_save {name.capitalize!}
  belongs_to :variation

  validates :stock, presence: true
  validates :stock, numericality: { greater_than_or_equal_to: 0 }
  validates :name, presence: true, uniqueness: { scope: [:variation_id], case_sensitive: false }

  def full_name
    return "#{self.variation.title} #{self.name}"
  end
end
