class TimedBlock < ApplicationRecord
  enum type: [:success, :peak]
  belongs_to :user
  belongs_to :exercise
end
