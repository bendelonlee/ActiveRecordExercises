class QueryScanner
  ALLOWED_KEYWORDS = %w(
    all first find find_by group having joins last
    left_outer_joins order offset select unscope where
    limit pluck
  ).to_set

  NON_KEYWORD_CHARS = %w(" ' :).to_set
  attr_reader :errors

  def default_table_names
    %w(Student Course Enrollment Teacher)
  end

  def names_with_prefix
    default_table_names.map{|name| "School::" + name}
  end

  def initialize(code = nil, table_names = names_with_prefix)
    @table_names = table_names
    @code = code
    @errors = []
  end

  def scan(code)
    @code = code
  end

  def safe?
    unpermitted = unpermitted_keywords
    if unpermitted.empty?
      return true
    else
      errors << [:security, ": Only activerecord queries will be executed : #{unpermitted.map{ |m| "`#{m}`"}.join(", ")} not permitted"]
      return false
    end
  end

  private

  def split_words
    @code.split(/[^\w"':]+/)
  end

  def keywords
    split_words.reject do |word|
      NON_KEYWORD_CHARS.include?(word[0]) || NON_KEYWORD_CHARS.include?(word[-1]) || word =~ /^\d+$/
    end
  end

  def unpermitted_keywords
    keywords.to_set.subtract(ALLOWED_KEYWORDS.merge(names_with_prefix))
  end

end
