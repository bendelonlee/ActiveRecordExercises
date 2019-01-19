class SolutionDecorator < Draper::Decorator
  delegate_all
  include ResultHelper
end
