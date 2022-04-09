class ApplicationController < ActionController::Base

  # DEVUELVE EL ULTIMO CARRITO DE COMPRA PARA UN USUARIO LOGEADO
  # SI NO EXISTE, CREA UNA NUEVA ORDEN (CARRITO)
  def current_order
    # si el usuario está logeado
    if current_user
      # busca el ultimo "carrito" para el usuario logeado
      order = Order.where(user_id: current_user.id).where(state: "created").last
      # si no existe, crea una nueva orden
      if order.nil?
        order = Order.create(user: current_user, state: "created")
      end

      # devuelve la orden
      return order
    end

    # si el usuario no esta logeado retorna nil
    nil
  end
end
