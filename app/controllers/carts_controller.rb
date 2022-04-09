class CartsController < ApplicationController
  before_action :authenticate_user!
  
  # AGREGA PRODUCTOS AL CARRO ACTUAL (order)
  def update
    # toma el product_id y 1 unidad de un produto del los campos ocultos del formulario
    product = params[:cart][:product_id]
    quantity = params[:cart][:quantity]

    # agrega el producto directamente a la tabla intermedia order_item
    # como si fuese inmediatamente comprado?
    current_order.add_product(product, quantity)

    redirect_to root_url, notice: "Product added successfuly"
  end

  # CARGA LOS PRODUCTOS DEL ULTIMO CARRO
  def show
    @order = current_order
  end

  def pay_with_paypal
    order = Order.find(params[:cart][:order_id])

    #price must be in cents
    price = order.total * 100

    response = EXPRESS_GATEWAY.setup_purchase(price,
      ip: request.remote_ip,
      return_url: process_paypal_payment_cart_url,
      cancel_return_url: root_url,
      allow_guest_checkout: true,
      currency: "USD"
    )

    payment_method = PaymentMethod.find_by(code: "PEC")
    Payment.create(
      order_id: order.id,
      payment_method_id: payment_method.id,
      state: "processing",
      total: order.total,
      token: response.token
    )

    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end

  def process_paypal_payment
    details = EXPRESS_GATEWAY.details_for(params[:token])
    express_purchase_options =
      {
        ip: request.remote_ip,
        token: params[:token],
        payer_id: details.payer_id,
        currency: "USD"
      }

    price = details.params["order_total"].to_d * 100

    response = EXPRESS_GATEWAY.purchase(price, express_purchase_options)
    if response.success?
      payment = Payment.find_by(token: response.token)
      order = payment.order

      #update object states
      payment.state = "completed"
      order.state = "completed"

      ActiveRecord::Base.transaction do
        order.save!
        payment.save!
      end
    end
  end
end
