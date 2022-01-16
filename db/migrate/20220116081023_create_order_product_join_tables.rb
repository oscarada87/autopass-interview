class CreateOrderProductJoinTables < ActiveRecord::Migration[7.0]
  def change
    create_table :order_product_join_tables do |t|
      t.references :order, null: false
      t.references :product, null: false

      t.timestamps
    end
  end
end
