require 'json'

# == Schema Information
#
# Table name: promotions
#
#  id         :integer          not null, primary key
#  rule       :string
#  category   :string
#  name       :string
#  rank       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Promotion < ApplicationRecord
  # rank 越大優先順序越高
  enum category: {
    full_discount_percentage: 'full_discount_percentage',
    full_discount_amount: 'full_discount_amount',
    product_capacity_discount_amount: 'product_capacity_discount_amount',
    full_giveaway: 'full_giveaway'
  }

  def serialize_rule
    JSON.parse(rule, symbolize_names: true)
  end
end
