require 'rails_helper'

RSpec.describe Solution, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe 'instance methods' do
    it '.ignore_inside_parens_after_allowed_kw' do
      code = 'Student.select("name, avg(enrollments.grade) as average_grade").joins(:enrollments).group(:id)'
      kw = 'select'
      expected = 'Student.select.joins(:enrollments).group(:id)'
      actual = Solution.new.ignore_inside_parens_after_allowed_kw(code, kw)
      expect(actual).to eq(expected)
    end
  end
end
