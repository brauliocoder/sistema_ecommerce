class Category < ApplicationRecord
  has_many :products

  has_many :subcategories, class_name: "Category", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent, class_name: "Category", optional: true

  def descendent_categories
    subcategories.map do |subcategory|
      subcategory.descendent_categories << subcategory.name
    end
  end

  def ascendent_parents
    a = [self.name]
    pp = parent
    while not pp.nil?
      a.append(pp.name)
      pp = pp.parent
    end

    return "/#{a.reverse().join("/")}"
  end
end