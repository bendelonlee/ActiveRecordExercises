require "rails_helper"
describe 'exercise index page' do
  it 'when I complete an exercise, this is indicated on the exercise index' do
    create(:user)
    Student.create!(name: 'b')
    user = create(:user)
    ex1 = create(:exercise, index: 1)
    ex2 = create(:exercise, index: 2)
    ex3 = Exercise.create!(name: "all", solution: "Student.all", instruction: "Write a query to return all Student models from the database.", index: 3)
    Completion.create!(exercise: ex1, user: user, times_completed: 4)
    Completion.create!(exercise: ex2, user: user, times_completed: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user.reload)
    visit exercise_path(ex3)
    fill_in :solution_solution_code, with: ex3.solution
    click_on 'execute'
    expect(page).to have_content('Success!')
    visit exercises_path
    within "#exercise-#{ex3.id}" do
      expect(page).to have_content "Completed 1 times"
    end
  end
end
