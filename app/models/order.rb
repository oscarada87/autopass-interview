require 'securerandom'

# == Schema Information
#
# Table name: orders
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  serial_number :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#

class Order < ApplicationRecord
  belongs_to :user
  has_many :order_product_join_tables
  has_many :products, through: :order_product_join_tables

  def self.generate_serial
    SecureRandom.uuid
  end

  def original_sum_price
    products.sum(:price)
  end
end
