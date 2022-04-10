json.extract! coupon, :id, :code, :one_use, :type, :discount, :created_at, :updated_at
json.url coupon_url(coupon, format: :json)
