module Calculators
  class Calculator
    def call(order:)
      build_entity(original_price: order.original_sum_price, final_price: final_price, giveaway: giveaway)
    end

    private

    def build_entity(original_price:, final_price:, giveaway:)
      CalculatedOrder.new(
        original_price: original_price,
        discount_amount: final_price - original_price,
        final_price: final_price,
        giveaway: giveaway
      )
    end

    class CalculatedOrder < Struct.new(:original_price, :discount_amount, :final_price, :giveaway)
    end
  end
end
