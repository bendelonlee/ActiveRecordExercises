class Exercise < ApplicationRecord
  validates_presence_of :name, :solution, :instruction

  def result
    @result ||= eval(solution)
  end
end
