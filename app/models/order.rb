# ORGANIZA EN UNA ORDEN LOS ITEMS QUE ESTAN EN LA TABLA ORDER_ITEM
# LOS USUARIOS PUEDEN HACER MULTIPLES ORDENES
class Order < ApplicationRecord
  before_create -> { generate_number(hash_size) }
  validates :number, uniqueness: true

  belongs_to :user

  has_many :order_items
  has_many :properties, through: :order_items

  has_many :payments

  belongs_to :coupon

  # ---------
  # GENERADOR DE LA CADENA ALEATORIA PARA NUMBER
  # Crea una cadena unica aleatorio para una orden
  def generate_number(size)
    # Chequea la condicion despues de ejecutar el loop
    self.number ||= loop do
      random = random_candidate(size)

      # Rompe el ciclo si no existe el numero generado
      break random unless self.class.exists?(number: random)
    end
  end

  # Concatena y genera la cadena aleatoria
  def random_candidate(size)
    "#{hash_prefix}#{Array.new(size){rand(size)}.join}"
  end

  # Prefijo que inicia la cadena
  def hash_prefix
    "BO"
  end

  # Define el largo de la cadena numerica que va despues del prefijo
  def hash_size
    9
  end
  # ---------

  # Crea una orden en la tabla intermedia orden_items
  def add_product(product_id, quantity)
    # ubica el producto en la tabla
    product = Property.find(product_id)

    # verifica que exista el producto y que tenga stock
    if product && (product.stock > 0)
      # crea la orden en la tabla intermedia
      order_items.create(property_id: product.id, quantity: quantity, price: product.price)
      
      # suma cada vez que se añade un producto, se suma al total
      compute_total
    end
  end

  
  # suma los productos que han sido agregados en la tabla intermedia
  def compute_total
    sum = 0
    order_items.each do |item|
      sum += item.price
    end

    # actualiza el valor de la suma total para la orden actual
    update_attribute(:total, sum)
  end

  def use_coupon(coupon_code)
    c = Coupon.find_by_code(coupon_code)

    if not c.nil?
      if c.one_use
        if c.orders.count < 1
          self.coupon_id = c.id
          self.save
        end
      else
        not_a_cheater = Order.where(user_id: self.user.id).where(coupon_id: c.id)
        if not_a_cheater.count == 0
          self.coupon_id = c.id
          self.save
        end
      end
    end
  end

  def discounted_price
    c = self.coupon

    total = self.total
    if not c.nil?
      if c.discount_type == "percentage"
        total = total * (100 - c.discount) / 100
      else
        if c.discount >= total
          total = 0
        else
          total -= c.discount
        end
      end
    end

    return total
  end

  def discount_in_human
    if not self.coupon.nil?
      if self.coupon.discount_type == "percentage"
        return "#{self.coupon.discount}\%"
      else
        return "\$#{self.coupon.discount}"
      end
    end
  end
end
