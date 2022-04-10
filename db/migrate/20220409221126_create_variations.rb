class CreateVariations < ActiveRecord::Migration[5.2]
  def change
    create_table :variations do |t|
      t.string :title
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
