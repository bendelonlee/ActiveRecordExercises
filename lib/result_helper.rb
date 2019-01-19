module ResultHelper
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
