module Calculators
  module Rules
    class Base
      def call(order_entity, params)
        raise NotImplementedError
      end
    end
  end
end
