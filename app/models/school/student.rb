class Student < School::Record
  has_many :enrollments
  has_many :classes, through: :enrollments
end
