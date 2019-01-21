require 'factory_bot_rails'

include FactoryBot::Syntax::Methods
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Exercise.destroy_all
Exercise.create!(name: "all", solution: "Course.all", instruction: "Write a query to return all Course models from the database.")
Exercise.create!(name: "average grades",
                solution: 'Student.select("name, avg(enrollments.grade) as average_grade").joins(:enrollments).group(:id)',
                instruction: "Write a query to return all students names and their average grades (as an attribute called average_grade) in this column order.")

Exercise.create!(name: "top grades",
                 solution: 'Student.select(:name, "AVG(enrollments.grade) AS average_grade").joins(:enrollments).group(:id).having("AVG(enrollments.grade) > (SELECT AVG(grade) FROM enrollments)")',
                 instruction: "Write a query to return all students names and their average grades (as an attribute called average_grade) in this column order, but only for students whose average grade is above the average of all grades")
      
