module ResultHelper

  def print_result
    if result.is_a?(Integer) || result.is_a?(Array)
      return h.haml_tag :p, result
    end
    # Rescue block certainly not ideal. I wanted to do something like `result.is_a?(ActiveRecord_Relation)` but it was not working
    begin
      result.count
      result_as_table
    rescue
      result_as_ruby
    end
  end

  def result_as_ruby
    result.inspect.gsub(",", ",\n").gsub("#", "\n")
  end

  def result_as_table
    data = result.as_json
    h.haml_tag :table do
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
end
