class Solution < ApplicationRecord
  belongs_to :exercise
  attr_reader :result
  ALLOWED_KEYWORDS = %w(all first find find_by joins last left_outer_joins order offset unscope where) +
                     %w(Product)

  def results?
    safe? && eval!
  end

  def safe?
    unpermitted = unpermitted_keywords
    if unpermitted.empty?
      return true
    else
      errors.add(:security, ": Only activerecord queries will be executed : #{unpermitted.map{ |m| "`#{m}`"}.join(", ")} not permitted")
      return false
    end
  end

  def unpermitted_keywords
    keywords - ALLOWED_KEYWORDS
  end

  def keywords
    ALLOWED_KEYWORDS.reduce(solution_code) do |code, kw|
      code.gsub(/(?<=#{kw})\(.*?\)/, "")
    end.split(/[^\w]+/)
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
