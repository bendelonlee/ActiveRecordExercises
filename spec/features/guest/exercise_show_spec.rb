require "rails_helper"
describe 'excercise show page' do
  it 'has the exercise name and instruction' do
    exercise = create(:exercise)
    visit exercise_path(exercise)
    expect(page).to have_content(exercise.name)
    expect(page).to have_content(exercise.instruction)
  end
  it 'when you execute your solution, you are told to sign up for an account' do
    exercise = create(:exercise)
    School::Student.create!(name: 'a')
    School::Student.create!(name: 'b')

    visit exercise_path(exercise)
    fill_in :solution_solution_code, with: "Student.all"
    click_on "execute"
    expect(page).to have_content("Log in or sign up to run your code!")
  end
end
