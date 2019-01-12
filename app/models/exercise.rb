class Exercise < ApplicationRecord
  validates_presence_of :name, :solution, :instruction
end
