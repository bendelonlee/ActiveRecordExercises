require "rails_helper"
describe 'exercise index page' do
  it 'has links to all the exercises' do
    ex1, ex2, ex3 = create_list(:exercise, 3)
    visit exercises_path
    expect(page).to have_link(ex1.name, href: exercise_path(ex1))
    expect(page).to have_link(ex2.name, href: exercise_path(ex2))
    expect(page).to have_link(ex3.name, href: exercise_path(ex3))
  end
end
