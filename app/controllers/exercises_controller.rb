class ExercisesController < ApplicationController
  def show
    @exercise = Exercise.find(params[:id])
    @form_path = [@exercise, Solution.new]
  end
end
