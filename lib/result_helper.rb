module ResultHelper
  def result_as_ruby
    result.inspect.gsub(",", ",\n").gsub("#", "\n")
  end
end
