FactoryBot.define do
  factory :timed_block do
    user { nil }
    exercise { nil }
    expiration { "2019-08-20 15:26:46" }
    type { 1 }
  end
end
