FactoryBot.define do
  factory :completion do
    user { nil }
    exercise { nil }
    times_completed { 1 }
  end
end
