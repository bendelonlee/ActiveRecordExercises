class TimedBlocksController < ApplicationController
  def create
    @exercise = Exercise.find(params[:exercise_id])
    TimedBlock.create(user: current_user, exercise: @exercise, expiration: 1.days.from_now, reason: :peeked)
    @show_answer = true
    @form_path = [@exercise, Solution.new]
    render "/exercises/show"
  end
end
