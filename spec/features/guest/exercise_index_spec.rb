require "rails_helper"
describe 'exercise index page' do
  it 'has links to all the exercises' do
    create(:user)
    # needed because stopgap current_user
    ex1, ex2, ex3 = create_list(:exercise, 3)
    visit exercises_path
    expect(page).to have_link(ex1.name, href: exercise_path(ex1))
    expect(page).to have_link(ex2.name, href: exercise_path(ex2))
    expect(page).to have_link(ex3.name, href: exercise_path(ex3))
  end
  it "shows me how many times I've completed an exercise, if I have completed it" do
    user = create(:user)
    ex1, ex2, ex3 = create_list(:exercise, 3)
    Completion.create!(exercise: ex1, user: user, times_completed: 4)
    Completion.create!(exercise: ex2, user: user, times_completed: 1)
    visit exercises_path
    within("#exercise-#{ex1.id}") do
      expect(page).to have_link(ex1.name, href: exercise_path(ex1))
      expect(page).to have_content("Completed 4 times")
    end
    within("#exercise-#{ex2.id}") do
      expect(page).to have_link(ex2.name, href: exercise_path(ex2))
      expect(page).to have_content("Completed 1 times")
    end
    within("#exercise-#{ex3.id}") do
      expect(page).to have_link(ex3.name, href: exercise_path(ex3))
      expect(page).to_not have_content("Completed")
    end\
  end
end
