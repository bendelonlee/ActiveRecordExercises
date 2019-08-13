class Exercise < ApplicationRecord
  validates_presence_of :name, :solution, :instruction

  def result
    @result ||= eval(Solution.add_prefix(solution))
  end
end
