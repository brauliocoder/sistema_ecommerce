class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :code
      t.boolean :one_use
      t.string :type
      t.integer :discount

      t.timestamps
    end
  end
end
