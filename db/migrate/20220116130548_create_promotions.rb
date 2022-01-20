class CreatePromotions < ActiveRecord::Migration[7.0]
  def change
    create_table :promotions do |t|
      t.string  :rule
      t.string  :category
      t.string  :name
      t.integer :rank, unique: true

      t.timestamps
    end
  end
end
