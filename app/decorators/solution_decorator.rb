class SolutionDecorator < Draper::Decorator
  include Draper::LazyHelpers
  
  delegate_all
  include ResultHelper
end
