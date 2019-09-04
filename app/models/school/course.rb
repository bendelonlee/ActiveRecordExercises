class Course < School::Record
  belongs_to :teacher
  has_many :enrollments
end
