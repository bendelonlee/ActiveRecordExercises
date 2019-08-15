class Enrollment < School::Record
  belongs_to :student
  belongs_to :course
end
