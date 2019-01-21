class Solution < ApplicationRecord
  belongs_to :exercise
  attr_reader :result
  ALLOWED_KEYWORDS = %w(all first find find_by group joins last left_outer_joins order offset select unscope where) +
                     %w(Student Course Enrollment Teacher)

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
      ignore_inside_parens_after_allowed_kw(code, kw)
    end.split(/[^\w]+/)
  end

  def ignore_inside_parens_after_allowed_kw(code, kw)
    paren_loc = code =~ /(?<=#{kw})\(/
    return code unless paren_loc
    cpl = closing_paren_loc(code, paren_loc)
    code[0...paren_loc] + code[cpl + 1..-1]    
  end

  def closing_paren_loc(code, paren_loc)
    i = paren_loc; openings = 1
    until i == code.size - 1
      i += 1
      case code[i]
      when '('
        openings += 1
      when ')'
        openings -= 1
      end
      return i if openings == 0
    end
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
