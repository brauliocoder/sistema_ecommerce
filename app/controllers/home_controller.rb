# GENERA EL CATALOGO DE PRODUCTOS
class HomeController < ApplicationController

  def index
    @products = Product.all
  end
end
