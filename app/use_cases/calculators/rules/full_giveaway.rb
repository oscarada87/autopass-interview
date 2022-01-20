module Calculators
  module Rules
    class FullGiveaway < Base
      # params
      # full_amount: 滿多少元
      # product_id: 贈品 ID
      # capacity: 贈品數量

      def call(order_entity:, params:)
        if order_entity.final_price >= params[:full_amount]
          order_entity.giveaway[params[:product_id].to_s.to_sym] = params[:capacity].to_i
        end

        order_entity
      end
    end
  end
end
