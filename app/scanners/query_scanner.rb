class QueryScanner
  ALLOWED_KEYWORDS = %w(
    all first find find_by group having joins last
    left_outer_joins order offset select unscope where
    limit pluck count avg as asc desc average
    CASE WHEN THEN ELSE END
  ).to_set

  NON_KEYWORD_CHARS = %w(" ' :).to_set
  attr_reader :errors

  def default_model_names
    %w(Student Course Enrollment Teacher)
  end

  def allowed_column_names
    %w(grade id room_number name av_grade highest_grade)
  end

  def allowed_db_names
    default_model_names +
    default_model_names.map{|name| name.downcase + 's'} +
    allowed_column_names
  end

  def initialize(code = nil, db_names = allowed_db_names)
    @db_names = db_names
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
    keywords.to_set.subtract(ALLOWED_KEYWORDS.merge(@db_names))
  end

end
