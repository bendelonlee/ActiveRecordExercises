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
User.destroy_all
Exercise.destroy_all

Exercise.create!(name: "All courses",
                 solution: "Course.all",
                 instruction: "Write a query to return all Course models from the database.",
                 notes: "Easy peasy.")

Exercise.create!(name: "All courses ordered by name",
                solution: "Course.order(name: :asc)",
                instruction: "Write a query to return all Course models from the database in ascending alphabetical order by name.",
                notes: "It is possible to write Course.order(:name) and the data will be returned in ascending order by default. However, if you care what order your results are returned in, it's better practice to be specific.")

Exercise.create!(name: "First student.",
                solution: "Student.order(name: :asc).first",
                instruction: "Write a query that returns the student model that's first in alphabetical order.",
                notes: "You can also use bracket syntax, i.e. `Student.order(name: :asc)[0]` however `.first` and `.last` are considered to be more human readable. Additionally, when you use bracket syntax, this SQL is run:\n
                SELECT \"students\".* FROM \"students\" ORDER BY \"students\".\"name\" ASC
                \n But when we use .first or .last, the SQL that's run looks more like this:
                SELECT  \"students\".* FROM \"students\" ORDER BY \"students\".\"name\" ASC LIMIT $1 [[\"LIMIT\", 1]]
                The `limit` means that only one object will be returned from the database, rather than all objects, which is more efficient.
                \n Other possible solutions: `Student.order(name: :desc).last")

Exercise.create!(name: "3 hardest courses.",
                solution: "Course.order(level: :desc).limit(3)",
                instruction: "Write a query that returns the top 3 courses by 'level' descending.",
                notes: "")




# Commenting out advanced exercises for the time being
# Exercise.create!(name: "average grades",
#                 solution: 'Student.select("name, avg(enrollments.grade) as average_grade").joins(:enrollments).group(:id)',
#                 instruction: "Write a query to return all students names and their average grades (as an attribute called average_grade) in this column order.")
#
# Exercise.create!(name: "top grades",
#                  solution: 'Student.select(:name, "AVG(enrollments.grade) AS average_grade").joins(:enrollments).group(:id).having("AVG(enrollments.grade) > (SELECT AVG(grade) FROM enrollments)")',
#                  instruction: "Write a query to return all students names and their average grades (as an attribute called average_grade) in this column order, but only for students whose average grade is above the average of all grades")
#
