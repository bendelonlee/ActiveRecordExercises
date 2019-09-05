class ExercisesController < ApplicationController
  def show
    @exercise = Exercise.find(params[:id]).decorate
    @form_path = [@exercise, Solution.new]
  end
  def index
    @basic_exercises = Exercise.where(level: :basic)
    @intermediate_exercises = Exercise.where(level: :intermediate)
    @advanced_exercises = Exercise.where(level: :advanced)
  end
end
