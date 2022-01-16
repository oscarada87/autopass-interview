FactoryBot.define do
  factory :order do
    serial_number { Order.generate_serial }
    user { association :user }
    products { build :product }
  end
end
