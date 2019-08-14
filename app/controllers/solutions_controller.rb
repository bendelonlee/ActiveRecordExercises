class SolutionsController < ApplicationController
  def create
    @exercise = Exercise.find(params[:exercise_id]).decorate
    @solution = Solution.new(solution_params).decorate
    @form_path = [@exercise, @solution]
    if @solution.results?
      success
    else
      @solution_errors = @solution.custom_error_messages
    end
    render "/exercises/show"
  end

  private

  def success
    @solution_results = true
    @correct_query = @solution.correct?
    @exercise.mark_completed_by(current_user)
  end

  def solution_params
    sps = params.require(:solution).permit(:solution_code)
    sps[:exercise_id] = params[:exercise_id]
    sps
  end
end
