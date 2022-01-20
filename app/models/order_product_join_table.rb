# == Schema Information
#
# Table name: order_product_join_tables
#
#  id         :integer          not null, primary key
#  order_id   :integer          not null
#  product_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_order_product_join_tables_on_order_id    (order_id)
#  index_order_product_join_tables_on_product_id  (product_id)
#

class OrderProductJoinTable < ApplicationRecord
  belongs_to :order
  belongs_to :product
end
