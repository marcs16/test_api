FactoryBot.define do
    factory :book do
      title { Faker::Book.title }
      published_at { Faker::Number.between(from: 1680, to: 1980) }
    end
end