module Calculators
  module Rules
    class Factory
      def self.call(category)
        case category
        when 'full_discount_percentage'
          ::Calculators::Rules::FullDiscountPercentage.new
        when 'full_discount_amount'
          ::Calculators::Rules::FullDiscountAmount.new
        when 'product_capacity_discount_amount'
          ::Calculators::Rules::ProductCapacityDiscountAmount.new
        when 'full_giveaway'
          ::Calculators::Rules::FullGiveaway.new
        end
      end
    end
  end
end
