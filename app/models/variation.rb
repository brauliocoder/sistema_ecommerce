class Variation < ApplicationRecord
  belongs_to :product

  has_many :properties, dependent: :destroy
end
