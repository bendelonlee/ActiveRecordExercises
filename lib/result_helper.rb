module ResultHelper
  def print_result
    if result.is_a?(String) || result.is_a?(Array) || result.is_a?(Integer)
      return h.haml_tag :p, result
    elsif result.is_a?(BigDecimal)
      return h.haml_tag :p, result.to_i
    elsif result.respond_to?(:id)
      return result_as_ruby
    elsif result.as_json.empty?
      return h.haml_tag :p, result
    else
      result_as_table
    end
  end

  def result_as_ruby
    h.haml_tag :p, result.inspect.gsub(",", ",\n").gsub("#", "\n")
  end

  def result_as_table
    data = result.as_json
    h.haml_tag :table do
      h.haml_tag :caption, table_name
      h.haml_tag :tr do
        data[0].keys.each do |heading|
          h.haml_tag :th, heading
        end
      end
      data.each do |row|
        h.haml_tag :tr do
          row.each do |heading, datum|
            h.haml_tag :td, datum
          end
        end
      end
    end
  end

  private

  def table_name
    result.class.to_s[/\w*/]
  end
end
