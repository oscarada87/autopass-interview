class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, index: true
      t.string :serial_number, unique: true

      t.timestamps
    end
  end
end
