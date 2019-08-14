School::Enrollment.destroy_all
School::Course.destroy_all
School::Teacher.destroy_all
School::Student.destroy_all

student_names =
[
"Zachary",
"Zion",
"Zane",
"Zander",
"Zachariah",
"Zayne",
"Zeke",
"Zain",
"Zev",
"Zeus",
"Zanya",
"Zeppo",
"Zabel",
"Zandy",
"Zabie",
"Zabrina",
"Zeda",
"Zadie",
"Zelda",
"Zaelia"
]
students = student_names.map.with_index do |name, i|
  {name: name, id: i + 1}
end
School::Student.import(students)

teacher_data = [
['McGuffin', 333],
['Vandergrift', 245],
['Snape', 101],
['Sinistra', 707],
['Hagrid', 115],
['Longbottom', 200],
['Firenze', 333],
['Babbling', 222],
['Espinosa', 323],
['Hooch', 543]
]
teachers = teacher_data.map.with_index do |teacher, i|
  {id: i + 1, name: teacher[0], room_number: teacher[1]}
end
School::Teacher.import(teachers)

course_data = [
   ['Wand Maintenence', 1],
   ['Muggle Studies', 1],
   ['Defence againt the Dark Arts', 2],
   ['Potions', 3],
   ['Astronomy', 4],
   ['Care of Magical Creatures', 5],
   ['Herbology', 6],
   ['Divination', 7],
   ['Study of Ancient Runes', 8],
   ['Rails Magic', 9],
   ['Flying', 10],
   ['Charms', 1]
]
courses = course_data.map.with_index do |course, i|
  {id: i + 1, name: course[0], teacher_id: course[1]}
end
School::Course.import(courses)

enrollment_data = [
   [1, 1, 60],
   [1, 9, 100],
   [2, 2, 90],
   [2, 4, 81],
   [3, 3, 99],
   [3, 2, 62],
   [4, 3, 82],
   [5, 3, 45],
   [5, 4, 60],
   [6, 4, 50],
   [6, 3, 70],
   [7, 8, 69],
   [7, 10, 76],
   [7, 9, 81],
   [7, 8, 91],
   [8, 8, 84],
   [9, 8, 88],
   [9, 7, 83],
   [10, 7, 93],
   [10, 5, 95],
   [11, 5, 91],
   [11, 8, 80],
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
   [16, 6, 78],
   [17, 7, 86],
   [17, 8, 91],
   [17, 9, 93],
   [18, 10, 95],
   [18, 9, 97],
   [19, 4, 84],
   [19, 9, 78],
   [20, 1, 85],
   [20, 11, 89],
   [20, 3, 98]
]

enrollments = enrollment_data.map.with_index do |enrollment, i|
  {id: i + 1, student_id: enrollment[0], course_id: enrollment[1], grade: enrollment[2]}
end
School::Enrollment.import(enrollments)
