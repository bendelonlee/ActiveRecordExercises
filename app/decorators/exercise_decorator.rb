class ExerciseDecorator < Draper::Decorator
  delegate_all
  include ResultHelper
end
