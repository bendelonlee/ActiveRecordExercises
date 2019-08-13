class Solution < ApplicationRecord
  belongs_to :exercise
  attr_reader :result

  def solution_code=(code)
    super(self.class.add_prefix(code))
  end

  def self.add_prefix(code)
    result = code.clone
    %w(Student Course Enrollment Teacher).each do | table_name |
      result.gsub!("#{table_name}", "School::#{table_name}")
    end
    result
  end

  def results?
    safe? && eval!
  end

  def safe?
    qs = QueryScanner.new(solution_code)
    if qs.safe?
      return true
    else
      qs.errors.each do |error|
        errors.add(error[0], error[1])
      end
      false
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

  def custom_error_messages
    errors.full_messages.map do |message|
      message.gsub("#{@db_name}::", '')
    end
  end
end
