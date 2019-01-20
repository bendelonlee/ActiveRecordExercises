Enrollment.destroy_all
Course.destroy_all
Teacher.destroy_all
Student.destroy_all

student_names =
[
'Penelope',
'Peter',
'Pepe',
'Parth',
'Priscilla',
'Pablo',
'Puja',
'Patricia',
'Piper',
'Paula',
'Pamela',
'Paige',
'Peggy',
'Pedro',
'Phoebe',
'Pajak',
'Parker',
'Priyal',
'Paxton',
'Patrick'
]
students = student_names.map.with_index do |name, i|
  {name: name, id: i + 1}
end
Student.import(students)

teacher_data = [
['Phillips', 456],
['Vandergrift', 120],
['Mauch', 101],
['Patel', 320],
['Marquez', 560],
['Boykin', 200],
['Phlop', 333],
['Pendergrass', 222],
['Palomo', 323],
['Altshuler', 543],
['Aleman', 187],
['Ashley', 432],
['Bonacci', 399],
['Brazukas', 287],
['Brockington', 299],
['Brizuela', 376],
['Burkhart', 199],
['Choi', 463],
['Shah', 354],
['Dimaggio', 251]
]
teachers = teacher_data.map.with_index do |teacher, i|
  {id: i + 1, name: teacher[0], room_number: teacher[1]}
end
Teacher.import(teachers)

course_data = [
   ['Cooking Pasta', 1],
   ['Yoga', 1],
   ['How to Guitar', 2],
   ['Gym', 3],
   ['Football', 4],
   ['Calculus', 5],
   ['Fruit', 6],
   ['Social Studies', 7],
   ['English', 8],
   ['Programming', 9],
   ['Singing', 10],
   ['Fashion', 1]
]
courses = course_data.map.with_index do |course, i|
  {id: i + 1, name: course[0], teacher_id: course[1]}
end
Course.import(courses)

enrollment_data = [
   [1, 1, 60],
   [2, 2, 70],
   [2, 4, 100],
   [3, 2, 74],
   [4, 3, 82],
   [5, 3, 45],
   [5, 4, 50],
   [7, 11, 62],
   [7, 10, 76],
   [7, 9, 81],
   [7, 8, 91],
   [8, 8, 84],
   [9, 8, 88],
   [9, 7, 83],
   [10, 7, 93],
   [10, 5, 95],
   [11, 5, 95],
   [11, 11, 80],
   [11, 6, 95],
   [11, 1, 94],
   [11, 2, 60],
   [12, 6, 55],
   [13, 7, 97],
   [14, 10, 86],
   [15, 9, 77],
   [15, 4, 93],
   [15, 1, 73],
   [16, 2, 79],
   [16, 6, 73],
   [17, 7, 86],
   [17, 8, 91],
   [17, 9, 93],
   [18, 10, 94],
   [19, 4, 84],
   [20, 1, 85],
   [20, 11, 89],
   [20, 3, 98]
]

enrollments = enrollment_data.map.with_index do |enrollment, i|
  {id: i + 1, student_id: enrollment[0], course_id: enrollment[1], grade: enrollment[2]}
end
Enrollment.import(enrollments)
