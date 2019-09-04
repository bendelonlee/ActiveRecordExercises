require 'factory_bot_rails'

include FactoryBot::Syntax::Methods
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Completion.destroy_all
TimedBlock.destroy_all
User.destroy_all
Exercise.destroy_all

Exercise.create!(name: "All courses",
                level: :basic,
                index: 1,
                 solution: "Course.all",
                 instruction: "Write a query to return all Course models from the database.",
                 notes: "Easy peasy.")

Exercise.create!(name: "All courses ordered by name",
                level: :basic,
                index: 2,
                solution: "Course.order(name: :asc)",
                instruction: "Write a query to return all Course models from the database in ascending alphabetical order by name.",
                notes: "It is possible to write Course.order(:name) and the data will be returned in ascending order by default. However, if you care what order your results are returned in, it's better practice to be specific.")

Exercise.create!(name: "First student",
                level: :basic,
                index: 3,
                solution: "Student.order(name: :asc).first",
                instruction: "Write a query that returns the student model that's first in alphabetical order.",
                notes: "You can also use bracket syntax, i.e. `Student.order(name: :asc)[0]` however `.first` and `.last` are considered to be more human readable. Additionally, when you use bracket syntax, this SQL is run:\n
                SELECT \"students\".* FROM \"students\" ORDER BY \"students\".\"name\" ASC
                \n But when we use .first or .last, the SQL that's run looks more like this:
                SELECT  \"students\".* FROM \"students\" ORDER BY \"students\".\"name\" ASC LIMIT $1 [[\"LIMIT\", 1]]
                The `limit` means that only one object will be returned from the database, rather than all objects, which is more efficient.
                \n Other possible solutions: `Student.order(name: :desc).last")

Exercise.create!(name: "3 hardest courses",
                level: :basic,
                index: 4,
                solution: "Course.order(level: :desc).limit(3)",
                instruction: "Write a query that returns the top 3 courses by 'level' descending.",
                notes: "")

Exercise.create!(name: "Average grade",
                level: :basic,
                index: 5,
                solution: "Enrollment.average('grade')",
                instruction: "Write a query that returns the average grade of all enrollments",
                notes: "")

Exercise.create!(name: "The total number of enrollments",
                level: :basic,
                index: 6,
                solution: "Enrollment.count",
                instruction: "Write a query that returns the count of all enrollments.",
                notes: "")

Exercise.create!(name: "All passing enrollments",
                level: :basic,
                index: 7,
                solution: "Enrollment.where('grade >= 60')",
                instruction: "Write a query that returns all enrollments where the grade is 60 or higher.",
                notes: "")

Exercise.create!(name: "The number of failing enrollments",
                level: :basic,
                index: 8,
                solution: "Enrollment.where('grade < 60').count",
                instruction: "Write a query that returns a count of enrollments where the grade is lower than 60.",
                notes: "")

Exercise.create!(name: "One student's enrollments",
                level: :basic,
                index: 9,
                solution: "Enrollment.where(student_id: [1])",
                instruction: "Write a query that returns the enrollments of the student with id 1.",
                notes: "")

Exercise.create!(name: "Two teacher's courses",
                level: :basic,
                index: 10,
                solution: "Enrollment.where(course_id: [1, 9])",
                instruction: "Write a query that returns the enrollments of the teachers with ids 1 and 9.",
                notes: "")

Exercise.create!(name: "The names of the 3 easiest courses",
                level: :intermediate,
                index: 11,
                solution: "Course.order(level: :asc).limit(3).pluck(:name)",
                instruction: "Write a query that returns a list of the names of the 3 courses with the lowest 'level' ascending.",
                notes: "")

Exercise.create!(name: "Rails Magic students",
                level: :intermediate,
                index: 12,
                solution: "Student.joins(enrollments: :course).where(courses: {name: 'Rails Magic'})",
                instruction: "Select a list of all students enrolled in the course with the name Rails Magic",
                notes: "If a has_many: :through relationship were defined in the Course model, one would be able to run `Course.find_by(name: 'Rails Magic').students`, however this would result in two queries to the database rather than one.")

Exercise.create!(name: "Courses by popularity",
                level: :intermediate,
                index: 13,
                solution: "Course.joins(:enrollments).group(:id).order('count(enrollments) desc')",
                instruction: "Write a query that returns the courses in descending order of their popularity (number of associated enrollments)",
                notes: "")

Exercise.create!(name: "Student names and their average grades",
                level: :intermediate,
                solution: 'Student.select("name, avg(enrollments.grade) as average_grade").joins(:enrollments).group(:id)',
                index: 14,
                instruction: "Write a query to return all students names and their average grades (as an attribute called average_grade) in this column order.",
                notes: "")

Exercise.create!(name: "McGuffin's students",
                level: :intermediate,
                solution: "Student.joins(enrollments: {course: :teacher}).where(teachers: {name: 'McGuffin'})",
                index: 15,
                instruction: "Select all students taught by the teacher with the name 'McGuffin'",
                notes: "")

Exercise.create!(name: "Teacher with the the most courses",
                level: :intermediate,
                solution: "Teacher.select('teachers.*, count(courses.id) as course_count').joins(:courses).group(:id).order('course_count desc').first",
                index: 16,
                instruction: "Write a query that selects the teacher with the most courses. Include the count of courses in the result as a column called 'course_count'.",
                notes: "")

Exercise.create!(name: "3 courses with highest elevation",
                level: :intermediate,
                solution: "Course.select('courses.*, teachers.room_number').joins(:teacher).group('teachers.room_number', :id).order('teachers.room_number desc').limit(3)",
                index: 17,
                instruction: "A courses's elevation is determined by the room_number column on the teacher table (700 room numbers are higher than 600 room numbers and so on). Write a query that returns the three most elevated courses",
                notes: "")

Exercise.create!(name: "Students by course count",
                level: :intermediate,
                solution: "Student.select('students.*, count(enrollments.id) as course_count').joins(:enrollments).group(:id).order('course_count asc, students.name asc')",
                index: 18,
                instruction: "Write a query that returns students ranked by number of course they are taking, ascending. Include the count as a column called 'course_count' in the results. Secondarily sort by student name, ascending",
                notes: "")

Exercise.create!(name: "Tough teachers",
                level: :intermediate,
                solution: "Teacher.select('teachers.*, max(enrollments.grade) as highest_grade).joins(courses: :enrollments).group(:id).having('max(enrollments.grade) < 90')",
                index: 19,
                instruction: "Select all teachers who have not given any A's (grades of 90 or above). Include a column called 'highest_grade' with the highest grade that teacher has given.",
                notes: "Keyword `having` is like `where`, except aggregate functions (such as max) are not allowed in a where clause.")

Exercise.create!(name: "Average grade in the course named Potions",
                level: :intermediate,
                index: 20,
                solution: "Course.select('avg(enrollments.grade) as av_grade').joins(:enrollments).group(:id).where(courses: {name: 'Potions'}).first.av_grade",
                instruction: "Write a query that returns the average grade for all enrollments for the course named 'Potions'",
                notes: "av_grade is a hidden column.")

Exercise.create!(name: "Count of each letter grade",
                level: :advanced,
                index: 21,
                solution: "Enrollment.select(\"count(id), CASE WHEN grade >= 90 THEN 'A' WHEN grade >= 80 THEN 'B' WHEN grade >= 70 THEN 'C' WHEN grade >= 60 THEN 'D' ELSE 'F' END as letter_grade\").group(:letter_grade).order('letter_grade ASC')",
                instruction: "Write a query that returns an activerecord relation with a column called 'letter_grade' ('A' for grades above 90, 'B' for above 80 and so on) and a count of all enrollments whose grade falls within that letter grade",
                notes: "* CASE WHEN syntax is specific for Postgres")






# Commenting out advanced exercises for the time being

# Exercise.create!(name: "top grades",
#                  solution: 'Student.select(:name, "AVG(enrollments.grade) AS average_grade").joins(:enrollments).group(:id).having("AVG(enrollments.grade) > (SELECT AVG(grade) FROM enrollments)")',
#                  instruction: "Write a query to return all students names and their average grades (as an attribute called average_grade) in this column order, but only for students whose average grade is above the average of all grades")
#
