FactoryBot.define do
  factory :exercise do
    name { "Using all"}
    instruction { "Write a query that returns all items from the database" }
    solution { "Product.all" }
  end
end
