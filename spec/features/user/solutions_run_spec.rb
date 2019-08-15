require "rails_helper"
describe 'there are no errors' do
  solutions =
  [
    "Course.all",
    "Course.order(name: :asc)",
    "Student.order(name: :asc).first",
    "Course.order(level: :desc).limit(3)",
    "Course.order(level: :asc).limit(3).pluck(:name)",
    "Enrollment.count",
    "Enrollment.where('grade >= 60')",
    "Course.order(level: :desc).limit(3)",
    "Enrollment.where(student_id: [1])",
    "Enrollment.where(course_id: [1, 9])"
  ]

  # "Enrollment.where(course_id: [1, 9])" and the one before it aren't great
  # tests. They both turn up empty. Thought of doing something like
  # s1.id in place of the hardcoded integer, would have to add s1 to the
  # whitelist. May be more trouble than it's worth.

  solutions.each do |solution|
    it 'when the solution code is run' do
      # More of a unit test would be more efficient. The obstacle I ran into was
      # the h.haml_tag line in ResultHelper doesn't function the same when there
      # isn't a controller involved.
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      s1, s2, s3 = create_list(:student, 3)
      t1, t2, t3 = create_list(:teacher, 3)
      c1 = create(:course, teacher: t1)
      c2 = create(:course, teacher: t2)
      c3 = create(:course, teacher: t3)
      create(:enrollment, student: s1, course: c1)
      create(:enrollment, student: s2, course: c2)
      create(:enrollment, student: s3, course: c3)

      ex1 = create(:exercise, solution: solution)
      visit exercise_path(ex1)
      fill_in :solution_solution_code, with: solution
      click_on "execute"
      sa
      expect(page).to have_content('Success!')
    end
  end
end
