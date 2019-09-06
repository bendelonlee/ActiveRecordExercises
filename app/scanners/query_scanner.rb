class QueryScanner
  ALLOWED_KEYWORDS = %w(
    all first find find_by group having joins last
    left_outer_joins order offset select unscope where
    limit pluck count avg as asc desc average min max
    case when then else end
  ).to_set

  attr_reader :errors

  def default_model_names
    %w(student course enrollment teacher)
  end

  def allowed_column_names
    %w(grade id room_number name level)
  end

  def allowed_miscellaneous
    %w(rails magic)
  end

  def column_ids
    default_model_names.map{|name| name + '_id'}
  end

  def allowed_db_names
    default_model_names +
    default_model_names.map{|name| name.downcase + 's'} +
    allowed_column_names +
    column_ids +
    allowed_miscellaneous
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
    result = []
    split_words.each do |word|
      next if result[-1] == 'as'
      next if word_in_quotes?(word)
      word = word_characters_only(word)
      next if just_numbers?(word)
      result << word.downcase
    end
    result
  end

  def word_characters_only(word)
    word.gsub(/\W/, '')
  end

  def word_in_quotes?(word)
    quote_marks = %w(' ")
    quote_marks.include?(word[0]) && word[-1] == word[0]
  end

  def just_numbers?(word)
    word =~ /^\d+$/ ? true : false
  end

  def unpermitted_keywords
    keywords.to_set.subtract(ALLOWED_KEYWORDS.merge(@db_names))
  end

end
