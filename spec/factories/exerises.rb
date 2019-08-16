FactoryBot.define do
  factory :exercise do
    name { "Using all"}
    instruction { "Write a query that returns all students from the database" }
    solution { "Student.all" }
    sequence(:index) { |n| n }
  end
end
