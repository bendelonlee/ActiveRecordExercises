require "rails_helper"
describe 'there are no errors' do
  solutions =
  [ "Course.all",
    "Course.order(name: :asc)",
    "Student.order(name: :asc).first",
    "Course.order(level: :desc).limit(3)",
    "Enrollment.average('grade')",
    "Enrollment.count",
    "Enrollment.where('grade >= 60')",
    "Enrollment.where('grade < 60').count",
    "Enrollment.where(student_id: [1])",
    "Course.where(teacher_id: [1, 9])",
    "Course.joins(:enrollments).group(:id).order('count(enrollments) desc')",
    "Course.order(level: :asc).limit(3).pluck(:name)",
    "Student.joins(enrollments: :course).where(courses: {name: 'Rails Magic'})",
    'Student.select("name, avg(enrollments.grade) as average_grade").joins(:enrollments).group(:id)',
    "Student.joins(enrollments: {course: :teacher}).where(teachers: {name: 'McGuffin'})",
    "Teacher.select('teachers.*, count(courses.id) as course_count').joins(:courses).group(:id).order('course_count desc').first",
    "Course.select('courses.*, teachers.room_number').joins(:teacher).group('teachers.room_number', :id).order('teachers.room_number desc').limit(3)",
    "Student.select('students.*, count(enrollments.id) as course_count').joins(:enrollments).group(:id).order('course_count asc, students.name asc')",
    "Teacher.joins(courses: :enrollments).group(:id).having('max(enrollments.grade) < 90')",
    "Course.select('avg(enrollments.grade) as av_grade').joins(:enrollments).group(:id).where(courses: {name: 'Potions'}).first.av_grade",
    "Enrollment.select(\"count(id), CASE WHEN grade >= 90 THEN 'A' WHEN grade >= 80 THEN 'B' WHEN grade >= 70 THEN 'C' WHEN grade >= 60 THEN 'D' ELSE 'F' END as letter_grade\").group(:letter_grade).order('letter_grade ASC')",
  ]

  # "Enrollment.where(course_id: [1, 9])" and the one before it aren't great
  # tests. They both turn up empty. Thought of doing something like
  # s1.id in place of the hardcoded integer, would have to add s1 to the
  # whitelist. May be more trouble than it's worth.
  let(:setup_db) do
    # More of a unit test would be more efficient. The obstacle I ran into was
    # the h.haml_tag line in ResultHelper doesn't function the same when there
    # isn't a controller involved.
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    s1, s2, s3 = create_list(:student, 3)
    t1, t2, t3 = create_list(:teacher, 3)
    t1.update(name: "McGuffin")
    c1 = create(:course, teacher: t1, name: 'Potions')
    c2 = create(:course, teacher: t2, name: 'Rails Magic')
    c3 = create(:course, teacher: t3)
    create(:enrollment, student: s1, course: c1)
    create(:enrollment, student: s2, course: c2)
    create(:enrollment, student: s3, course: c3)
  end
  solutions.each do |solution|
    it 'when the solution code is run' do
      setup_db
      ex1 = create(:exercise, solution: solution)
      visit exercise_path(ex1)
      fill_in :solution_solution_code, with: solution
      click_on "execute"
      expect(page).to have_content('Success!')
    end
  end
  it 'when the answer is an integer' do
    setup_db
    solution = "Enrollment.count"
    ex1 = create(:exercise, solution: solution)
    visit exercise_path(ex1)
    fill_in :solution_solution_code, with: solution
    click_on "execute"
    within "#actual" do
      expect(page).to have_content('3')
    end
  end
  it 'when the answer is an array' do
    setup_db
    solution = "Course.order(level: :asc).limit(3).pluck(:name)"
    ex1 = create(:exercise, solution: solution)
    visit exercise_path(ex1)
    fill_in :solution_solution_code, with: solution
    click_on "execute"
    within "#actual" do
      expect(page).to have_content(Course.order(level: :asc).limit(3).pluck(:name).to_s)
    end
  end
end
