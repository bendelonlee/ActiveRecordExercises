class SolutionsController < ApplicationController
  def create
    @exercise = Exercise.find(params[:exercise_id]).decorate
    @solution = Solution.new(solution_params).decorate
    @form_path = [@exercise, Solution.new]
    if @solution.results?
      @solution_results = true
      @correct_query = @solution.correct?
    else
      @solution_errors = @solution.errors.full_messages
    end
    render "/exercises/show"
  end

  def solution_params
    sps = params.require(:solution).permit(:solution_code)
    sps[:exercise_id] = params[:exercise_id]
    sps
  end
end
