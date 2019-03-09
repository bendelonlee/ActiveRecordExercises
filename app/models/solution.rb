class Solution < ApplicationRecord
  belongs_to :exercise
  attr_reader :result

  def results?
    safe? && eval!
  end

  def eval!
    begin
      @result = eval(solution_code)
      @result.as_json
    rescue Exception => exc
      errors.add(:Exception, exc.message)
      return false
    end
  end

  def correct?
    result == exercise.result
  end
end
