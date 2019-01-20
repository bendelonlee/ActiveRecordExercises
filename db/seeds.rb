require 'factory_bot_rails'

include FactoryBot::Syntax::Methods
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
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
require 'pry'; binding.pry
