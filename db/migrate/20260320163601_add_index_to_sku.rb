class AddIndexToSku < ActiveRecord::Migration[7.1]
  def change
    add_index :product_variants, :sku, unique: true
  end
end
