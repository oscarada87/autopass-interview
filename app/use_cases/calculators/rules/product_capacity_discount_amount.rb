module Calculators
  module Rules
    class ProductCapacityDiscountAmount < Base
      # params
      # product_id: 商品 ID
      # capacity: 滿多少件
      # discount_amount: 折多少元

      def call(order_entity:, params:)
        capacity = order_entity.order.products.where(id: params[:product_id]).count
        if capacity >= params[:capacity]
          order_entity.final_price -= params[:discount_amount].to_i
        end

        order_entity
      end
    end
  end
end
