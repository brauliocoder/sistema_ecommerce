class RenameTypeToDiscountTypeInCoupons < ActiveRecord::Migration[5.2]
  def change
    rename_column :coupons, :type, :discount_type
  end
end
