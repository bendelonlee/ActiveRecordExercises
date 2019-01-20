class Enrollment < SchoolRecord
  belongs_to :student
  belongs_to :course
end
