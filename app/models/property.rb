class Property < ApplicationRecord
  before_save {name.capitalize!}
  belongs_to :variation

  validates :stock, presence: true
  validates :name, presence: true, uniqueness: { scope: [:variation_id], case_sensitive: false }
end
