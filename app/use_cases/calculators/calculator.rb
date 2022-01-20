module Calculators
  class Calculator
    def call(order:, promotions:)
      order_entity = build_origin_entity(order)
      calculate(order_entity: order_entity, promotions: promotions)
    end

    private

    def build_origin_entity(order)
      CalculatedOrder.new(
        order: order,
        original_price: order.original_sum_price,
        discount_amount: 0,
        final_price: order.original_sum_price,
        giveaway: {}
      )
    end

    def calculate(order_entity:, promotions:)
      calculated_order = order_entity
      promotions.sort_by(&:rank).reverse_each do |promotion|
        rule = ::Calculators::Rules::Factory.call(promotion.category)
        calculated_order = rule.call(order_entity: calculated_order, params: promotion.serialize_rule)
      end
      calculated_order
    end

    class CalculatedOrder < Struct.new(:order, :original_price, :final_price, :giveaway)
      def initialize(**kwargs)
        super(*members.map{|k| kwargs[k] })
      end

      def discount_amount
        original_price - final_price
      end
    end
  end
end
