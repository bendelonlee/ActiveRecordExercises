class SolutionsController < ApplicationController
  def create
    solution = Solution.new(solution_params)
    @exercise = Exercise.find(params[:exercise_id])
    @form_path = [@exercise, Solution.new]

    if solution.safe?
      @actual_results = eval(solution.solution_code)
      @expected_results = eval(@exercise.solution)
      @correct_query = @actual_results == @expected_results
    else
      @security_errors = solution.errors.full_messages
    end
    render "/exercises/show"
  end

  def solution_params
    params.require(:solution).permit(:solution_code)
  end
end
