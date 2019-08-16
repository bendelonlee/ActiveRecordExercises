require "rails_helper"
describe 'the next and previous links on the exercise show page' do
  it 'shows the next and previous links' do
    ex1, ex2, ex3 = create_list(:exercise, 3)
    visit exercise_path(ex2)
    within "#top-exercise-nav" do
      expect(page).to have_content('Next Exercise')
      expect(page).to have_content('Previous Exercise')
    end
    within "#bottom-exercise-nav" do
      expect(page).to have_content('Next Exercise')
      expect(page).to have_content('Previous Exercise')
    end
  end
  it 'the next link takes you the next exercise' do
    ex1 = create(:exercise, index: 1)
    ex2 = create(:exercise, index: 2)
    visit exercise_path(ex1)
    within "#top-exercise-nav" do
      click_on('Next Exercise')
    end
    expect(current_path).to eq(exercise_path(ex2))

    visit exercise_path(ex1)
    within "#bottom-exercise-nav" do
      click_on('Next Exercise')
    end
    expect(current_path).to eq(exercise_path(ex2))
  end
  it 'the previous link takes you the previous exercise' do
    ex1 = create(:exercise, index: 1)
    ex2 = create(:exercise, index: 2)
    visit exercise_path(ex2)
    within "#top-exercise-nav" do
      click_on('Previous Exercise')
    end
    expect(current_path).to eq(exercise_path(ex1))

    visit exercise_path(ex2)
    within "#bottom-exercise-nav" do
      click_on('Previous Exercise')
    end
    expect(current_path).to eq(exercise_path(ex1))
  end

  it 'previous and next buttons do not appear when not appropriate' do
    ex1 = create(:exercise, index: 4)
    ex2 = create(:exercise, index: 5)
    visit exercise_path(ex2)
    expect(page).to_not have_content("Next Exercise")

    visit exercise_path(ex1)
    expect(page).to_not have_content("Previous Exercise")

  end

end
