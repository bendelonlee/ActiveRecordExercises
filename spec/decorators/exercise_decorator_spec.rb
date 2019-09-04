require 'rails_helper'

RSpec.describe ExerciseDecorator do
  it 'prints the solution pretty' do
    exercise = create(:exercise, solution: "Teacher.select('teachers.*, count(courses.id) as course_count').joins(:courses).group(:id).order('course_count desc').first")
    exercise = exercise.decorate
    expect(exercise.solution_pretty).to eq("Teacher.select('teachers.*, count(courses.id) as course_count')\n       .joins(:courses)\n       .group(:id)\n       .order('course_count desc')\n       .first")
  end
end
