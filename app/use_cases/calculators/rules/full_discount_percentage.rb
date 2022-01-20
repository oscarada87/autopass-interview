module Calculators
  module Rules
    class FullDiscountPercentage < Base
      # params
      # full_amount: 滿多少金額
      # discount_percentage: 總金額 * 幾 %

      def call(order_entity:, params:)
        if order_entity.final_price >= params[:full_amount]
          order_entity.final_price = (order_entity.final_price * params[:discount_percentage].to_f).round
        end

        order_entity
      end
    end
  end
end
