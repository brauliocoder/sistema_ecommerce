class Variation < ApplicationRecord
  belongs_to :product
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  
  has_many :properties, dependent: :destroy
end
