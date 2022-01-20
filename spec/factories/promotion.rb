FactoryBot.define do
  factory :promotion do
    rule { '{"full_amount":150,"discount_percentage":0.9}' }
    category { :full_discount_percentage }
    name { '測試優惠1號' }
    rank { nil }
  end
end
