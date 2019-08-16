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
end
