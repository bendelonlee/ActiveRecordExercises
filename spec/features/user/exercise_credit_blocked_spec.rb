require "rails_helper"
describe 'exercise index page' do
  it 'when I peak at an exercise, this is indicated. I am not able to get credit for completing it until 24 hours pass.' do
    create(:user)
    Student.create!(name: 'b')
    user = create(:user)
    ex1 = create(:exercise, index: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user.reload)
    visit exercise_path(ex1)
    click_on("#toggle-button")
    expect(page).to have_content("Because you've seen our answer before writing your own, you must wait 24 hours before your completion will be counted.")
    fill_in :solution_solution_code, with: ex1.solution
    click_on 'execute'
    expect(page).to have_content('You will be able to complete this exercise in 24 hours')
    visit exercises_path
    within "#exercise-#{ex3.id}" do
      expect(page).to have_content "Completed 0 times"
    end
  end
end
