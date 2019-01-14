class SolutionsController < ApplicationController
  def create
    solution = Solution.new(solution_params)
    @exercise = Exercise.find(params[:exercise_id])
    @expected_results = eval(@exercise.solution)
    @actual_results = eval(solution.solution_code)
    @correct_query = @actual_results == @expected_results
    @form_path = [@exercise, Solution.new]

    render "/exercises/show"
  end

  def solution_params
    params.require(:solution).permit(:solution_code)
  end
end
