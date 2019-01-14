class Solution < ApplicationRecord
  ALLOWED_KEYWORDS = %w(all first find find_by joins last left_outer_joins order offset unscope where) +
                     %w(Item)

  def safe?
    unpermitted = unpermitted_keywords
    if unpermitted.empty?
      return true
    else
      self.errors.add(:security, ": Only activerecord queries will be executed : #{unpermitted.map{ |m| "`#{m}`"}.join(", ")} not permitted")
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
end
