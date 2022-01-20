require 'rails_helper'

RSpec.describe Calculators::Calculator do
  describe '單一折扣' do
    subject(:calculator) { described_class.new }
    let(:product) do
      create(:product, price: 100, name: 'productA')
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

    context '訂單滿 150 元折 10%' do
      let!(:promotions) do
        [
          create(
            :promotion,
            rule: '{"full_amount":150,"discount_percentage":0.9}',
            category: :full_discount_percentage,
            rank: 1,
          )
        ]
      end

      it do
        result = calculator.call(order: order, promotions: promotions)
        expect(result.final_price).to eq(180)
        expect(result.original_price).to eq(200)
        expect(result.giveaway).to eq({})
      end
    end

    context '訂單滿 150 元折 10 元' do
      let!(:promotions) do
        [
          create(
            :promotion,
            rule: '{"full_amount":150,"discount_amount":10}',
            category: :full_discount_amount,
            rank: 1,
          )
        ]
      end

      it do
        result = calculator.call(order: order, promotions: promotions)
        expect(result.final_price).to eq(190)
        expect(result.original_price).to eq(200)
        expect(result.giveaway).to eq({})
      end
    end

    context '商品A滿 2 件折 30元' do
      let!(:promotions) do
        [
          create(
            :promotion,
            rule: %{{"product_id":#{product.id},"capacity":2,"discount_amount":30}},
            category: :product_capacity_discount_amount,
            rank: 1,
          )
        ]
      end

      it do
        result = calculator.call(order: order, promotions: promotions)
        expect(result.final_price).to eq(170)
        expect(result.original_price).to eq(200)
        expect(result.giveaway).to eq({})
      end
    end

    context '訂單滿 150 元贈送商品 A 一件' do
      let!(:promotions) do
        [
          create(
            :promotion,
            rule: %{{"full_amount":150,"product_id":#{product.id},"capacity":1}},
            category: :full_giveaway,
            rank: 1,
          )
        ]
      end

      it do
        result = calculator.call(order: order, promotions: promotions)
        expect(result.final_price).to eq(200)
        expect(result.original_price).to eq(200)
        expect(result.giveaway[product.id.to_s.to_sym]).to eq(1)
      end
    end
  end

  describe '組合折扣' do
    subject(:calculator) { described_class.new }
    let(:product) do
      create(:product, price: 100, name: 'productA')
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

    context '訂單滿 150 元折 10 元再折 10%' do
      let!(:promotions) do
        [
          create(
            :promotion,
            rule: '{"full_amount":150,"discount_percentage":0.9}',
            category: :full_discount_percentage,
            rank: 1,
          ),
          create(
            :promotion,
            rule: '{"full_amount":150,"discount_amount":10}',
            category: :full_discount_amount,
            rank: 2,
          )
        ]
      end

      it do
        result = calculator.call(order: order, promotions: promotions)
        expect(result.final_price).to eq(171)
        expect(result.original_price).to eq(200)
        expect(result.giveaway).to eq({})
      end
    end

    context '訂單滿 150 元折 10% 再折 10元' do
      let!(:promotions) do
        [
          create(
            :promotion,
            rule: '{"full_amount":150,"discount_percentage":0.9}',
            category: :full_discount_percentage,
            rank: 2,
          ),
          create(
            :promotion,
            rule: '{"full_amount":150,"discount_amount":10}',
            category: :full_discount_amount,
            rank: 1,
          )
        ]
      end

      it do
        result = calculator.call(order: order, promotions: promotions)
        expect(result.final_price).to eq(170)
        expect(result.original_price).to eq(200)
        expect(result.giveaway).to eq({})
      end
    end

    context '訂單滿 150 元折 10% 未滿 190 元不送贈品' do
      let!(:promotions) do
        [
          create(
            :promotion,
            rule: '{"full_amount":150,"discount_percentage":0.9}',
            category: :full_discount_percentage,
            rank: 2,
          ),
          create(
            :promotion,
            rule: %{{"full_amount":190,"product_id":#{product.id},"capacity":1}},
            category: :full_giveaway,
            rank: 1,
          )
        ]
      end

      it do
        result = calculator.call(order: order, promotions: promotions)
        expect(result.final_price).to eq(180)
        expect(result.original_price).to eq(200)
        expect(result.giveaway).to eq({})
      end
    end
  end
end
