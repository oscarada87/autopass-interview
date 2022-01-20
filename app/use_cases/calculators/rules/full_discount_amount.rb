module Calculators
  module Rules
    class FullDiscountAmount < Base
      # params
      # full_amount: 滿多少金額
      # discount_amount: 折多少元

      def call(order_entity:, params:)
        if order_entity.final_price >= params[:full_amount]
          order_entity.final_price -= params[:discount_amount].to_i
        end

        order_entity
      end
    end
  end
end
