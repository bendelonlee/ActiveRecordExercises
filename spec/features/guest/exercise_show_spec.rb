require "rails_helper"
describe 'excercise show page' do
  it 'has the exercise name and instruction' do
    exercise = create(:exercise)
    visit exercise_path(exercise)
    expect(page).to have_content(exercise.name)
    expect(page).to have_content(exercise.instruction)
  end
  it 'when you execute your solution, you see your results next to the results returned by the correct solution' do
    exercise = create(:exercise)
    item = create_list(:item, 3)
    # item = create_list(:item, 3)
    visit exercise_path(exercise)
    fill_in :solution_solution_code, with: "Item.all"
    click_on "execute"
    expect(page).to have_content("Expected Results:")
    expect(page).to have_content("Your Query Returned:")
    expect(page).to have_content("Success!")
  end
  xit 'hides the solution. But when you press the "show solution" button it shows the solution. You can then press "hide solution" which hides the solution' do
    #got the functionality working with js, not sure how to test
    exercise = create(:exercise)
    visit exercise_path(exercise)
    save_and_open_page
    expect(page).to_not have_content(exercise.solution)
    click_on "show solution"
    expect(page).to have_content(exercise.solution)

  end

end
