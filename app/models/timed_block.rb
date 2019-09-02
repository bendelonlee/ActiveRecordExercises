class TimedBlock < ApplicationRecord
  enum reason: [:success, :peeked]
  belongs_to :user
  belongs_to :exercise
end
