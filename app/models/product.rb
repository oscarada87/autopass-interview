# == Schema Information
#
# Table name: products
#
#  id         :integer          not null, primary key
#  price      :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Product < ApplicationRecord
  has_many :order_product_join_tables
  has_many :orders, through: :order_product_join_tables
end
