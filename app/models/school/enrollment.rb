class School::Enrollment < School::SchoolRecord
  belongs_to :student
  belongs_to :course
end
