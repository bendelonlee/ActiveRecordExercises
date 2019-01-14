class ExerciseObjectBase < ActiveRecord::Base
  establish_connection DB_EXOB
  self.abstract_class = true
end
