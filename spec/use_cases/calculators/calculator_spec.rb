require 'rails_helper'

RSpec.describe Calculators::Calculator do
  describe 'test' do
    subject(:calculator) { described_class.new }

    context '訂單滿 100 元折 10%' do
      let(:product) do
        create(:product, price: 100)
      end

      let(:order) do
        create(
          :order,
          products: [
            product,
            product
          ]
        )
      end

      it do
        binding.break
        expect(calculator.call(order: order).final_price).to eq(90)
      end
    end
  end
end
